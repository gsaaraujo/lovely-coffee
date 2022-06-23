import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/home/domain/entities/favorite_product_entity.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/favorite_products_datasource.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/favorite_products_repository.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';
import 'package:lovely_coffee/modules/home/infra/models/favorite_product_model.dart';

class FavoriteProductsRepositoryImpl implements FavoriteProductsRepository {
  FavoriteProductsRepositoryImpl(this._datasource, this._connectivityService);

  final FavoriteProductsDatasource _datasource;
  final DeviceConnectivityService _connectivityService;

  @override
  Future<Either<BaseException, void>> addOrRemoveProductToFavorites(
      String productId, String userId) async {
    try {
      final bool hasNoConnection =
          !(await _connectivityService.hasDeviceConnection());

      if (hasNoConnection) {
        return Left(NoDeviceConnectionException());
      }

      await _datasource.addOrRemoveProductToFavorites(productId, userId);

      return const Right(null);
    } on BaseException catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<BaseException, List<FavoriteProductEntity>>>
      findAllFavoriteProductsByUserId(String userId) async {
    try {
      final bool hasNoConnection =
          !(await _connectivityService.hasDeviceConnection());

      if (hasNoConnection) {
        return Left(NoDeviceConnectionException());
      }

      final favoriteProductsModelList =
          await _datasource.findAllFavoriteProductsByUserId(userId);

      final favoriteProductsEntityList = favoriteProductsModelList
          .map((favoriteProductsEntity) => favoriteProductsEntity.toEntity())
          .toList();

      return Right(favoriteProductsEntityList);
    } on BaseException catch (exception) {
      return Left(exception);
    }
  }
}
