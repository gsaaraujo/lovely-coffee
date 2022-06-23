import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';
import 'package:lovely_coffee/modules/home/infra/repositories/products_repository_impl.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class MockProductsDatasource extends Mock implements ProductsDatasource {}

class MockDeviceConnectivityService extends Mock
    implements DeviceConnectivityService {}

void main() {
  late ProductsDatasource mockDatasource;
  late ProductsRepository repository;
  late DeviceConnectivityService mockDeviceConnectivityService;

  setUp(() {
    mockDatasource = MockProductsDatasource();
    mockDeviceConnectivityService = MockDeviceConnectivityService();

    repository = ProductsRepositoryImpl(
      mockDatasource,
      mockDeviceConnectivityService,
    );
  });

  const fakeProductEntity = ProductEntity(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 25.50,
  );

  const fakeProductModel = ProductModel(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 25.50,
  );

  test('findAllProducts should return a list of ProductEntity', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.findAllProducts())
        .thenAnswer((_) async => [fakeProductModel]);

    final productList = await repository.findAllProducts();

    verify(() => mockDeviceConnectivityService.hasDeviceConnection());
    verify(() => mockDatasource.findAllProducts());
    expect(productList.fold(id, id), [fakeProductEntity]);
  });

  test('findAllProducts should return NoDeviceConnectionException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => false);

    final productList = await repository.findAllProducts();

    verify(() => mockDeviceConnectivityService.hasDeviceConnection());
    expect(productList.fold(id, id), NoDeviceConnectionException());
  });

  test('findAllProducts should return a UnknownException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.findAllProducts()).thenThrow(UnknownException());

    final productList = await repository.findAllProducts();

    verify(() => mockDeviceConnectivityService.hasDeviceConnection());
    verify(() => mockDatasource.findAllProducts());
    expect(productList.fold(id, id), UnknownException());
  });
}
