import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';
import 'package:lovely_coffee/modules/home/infra/repositories/products_repository_impl.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/favorite_products_datasource.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class MockProductsDatasource extends Mock implements ProductsDatasource {}

class MockFavoriteProductsDatasource extends Mock
    implements FavoriteProductsDatasource {}

class MockDeviceConnectivityService extends Mock
    implements DeviceConnectivityService {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  late ProductsDatasource mockProductsDatasource;
  late FavoriteProductsDatasource mockFavoriteProductsDatasource;
  late ProductsRepository repository;
  late LocalStorageService mockLocalStorageService;
  late DeviceConnectivityService mockDeviceConnectivityService;

  setUp(() {
    mockProductsDatasource = MockProductsDatasource();
    mockFavoriteProductsDatasource = MockFavoriteProductsDatasource();
    mockDeviceConnectivityService = MockDeviceConnectivityService();
    mockLocalStorageService = MockLocalStorageService();

    repository = ProductsRepositoryImpl(
      mockProductsDatasource,
      mockFavoriteProductsDatasource,
      mockDeviceConnectivityService,
      mockLocalStorageService,
    );
  });

  const fakeProductEntity = ProductEntity(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 25.50,
    isFavorite: false,
  );

  const fakeProductModel = ProductModel(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 2550,
  );

  const fakeUserLocalStorage = UserLocalStorageEntity(
    uid: '123',
    imageUrl: 'www.productUrl.com',
    name: 'Gabriel',
  );

  test('findAllProducts should return a list of ProductEntity', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockLocalStorageService.getUser())
        .thenAnswer((_) async => const Right(fakeUserLocalStorage));

    when(() => mockProductsDatasource.findAllProducts())
        .thenAnswer((_) async => [fakeProductModel]);

    final productList = await repository.findAllProducts();

    verify(() => mockDeviceConnectivityService.hasDeviceConnection());
    verify(() => mockProductsDatasource.findAllProducts());
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

    when(() => mockProductsDatasource.findAllProducts())
        .thenThrow(UnknownException());

    final productList = await repository.findAllProducts();

    verify(() => mockDeviceConnectivityService.hasDeviceConnection());
    verify(() => mockProductsDatasource.findAllProducts());
    expect(productList.fold(id, id), UnknownException());
  });
}
