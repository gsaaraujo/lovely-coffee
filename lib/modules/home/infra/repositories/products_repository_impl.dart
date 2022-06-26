import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/favorite_product_model.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/favorite_products_datasource.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(
    this._productsDatasource,
    this._favoritesDatasource,
    this._connectivityService,
    this._localStorageService,
  );

  final ProductsDatasource _productsDatasource;
  final FavoriteProductsDatasource _favoritesDatasource;

  final LocalStorageService _localStorageService;
  final DeviceConnectivityService _connectivityService;

  @override
  Future<Either<BaseException, List<ProductEntity>>> findAllProducts({
    String? filter,
  }) async {
    try {
      final bool hasNoConnection =
          !(await _connectivityService.hasDeviceConnection());

      if (hasNoConnection) {
        return Left(NoDeviceConnectionException());
      }

      final UserLocalStorageEntity user = await _localStorageService.getUser();

      final List<ProductModel> productModelList =
          await _productsDatasource.findAllProducts();

      final List<FavoriteProductModel> favoriteModelList =
          await _favoritesDatasource.findAllFavoriteProductsByUserId(user.uid);

      final List<String> favoriteProductIDList =
          favoriteModelList.map((favorite) => favorite.productId).toList();

      final List<ProductEntity> productEntityList = productModelList.map(
        (productModel) {
          return ProductEntity(
            id: productModel.id,
            imageUrl: productModel.imageUrl,
            name: productModel.name,
            additionalInfo: productModel.additionalInfo,
            description: productModel.description,
            price: productModel.price / 100,
            isFavorite: favoriteProductIDList.contains(productModel.id),
          );
        },
      ).toList();

      return Right(productEntityList);
    } on BaseException catch (exception) {
      return Left(exception);
    }
  }
}
