import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/domain/entities/favorite_product_entity.dart';

abstract class FavoriteProductsRepository {
  Future<Either<BaseException, void>> addOrRemoveProductToFavorites(
    String productId,
    String userId,
  );

  Future<Either<BaseException, List<FavoriteProductEntity>>>
      findAllFavoriteProductsByUserId(
    String userId,
  );
}
