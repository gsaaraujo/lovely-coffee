import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/favorite_products_datasource.dart';
import 'package:lovely_coffee/modules/home/infra/repositories/favorite_products_repository_impl.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class MockFavoriteProductsDatasource extends Mock
    implements FavoriteProductsDatasource {}

class MockDeviceConnectivityService extends Mock
    implements DeviceConnectivityService {}

void main() {
  late FavoriteProductsDatasource datasource;
  late FavoriteProductsRepositoryImpl repository;
  late DeviceConnectivityService connectivityService;

  const productId = '123';
  const userId = '777';

  setUp(() {
    datasource = MockFavoriteProductsDatasource();
    connectivityService = MockDeviceConnectivityService();
    repository =
        FavoriteProductsRepositoryImpl(datasource, connectivityService);
  });

  test('faddOrRemoveProductToFavorites should return void when successful',
      () async {
    when(() => connectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => datasource.addOrRemoveProductToFavorites(productId, userId))
        .thenAnswer((_) async => () {});

    final response =
        await repository.addOrRemoveProductToFavorites(productId, userId);

    verify(() => connectivityService.hasDeviceConnection());
    verify(() => datasource.addOrRemoveProductToFavorites(productId, userId));

    expect(response.fold(id, (r) => null), null);
  });

  test(
      'faddOrRemoveProductToFavorites should return a NoDeviceConnectionException',
      () async {
    when(() => connectivityService.hasDeviceConnection())
        .thenAnswer((_) async => false);

    final response =
        await repository.addOrRemoveProductToFavorites(productId, userId);

    verify(() => connectivityService.hasDeviceConnection());

    expect(response.fold(id, (r) => null), NoDeviceConnectionException());
  });

  test('faddOrRemoveProductToFavorites should return BaseExceptionl', () async {
    when(() => connectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => datasource.addOrRemoveProductToFavorites(productId, userId))
        .thenThrow(UnknownException());

    final response =
        await repository.addOrRemoveProductToFavorites(productId, userId);

    verify(() => connectivityService.hasDeviceConnection());
    verify(() => datasource.addOrRemoveProductToFavorites(productId, userId));

    expect(response.fold(id, (r) => null), UnknownException());
  });
}
