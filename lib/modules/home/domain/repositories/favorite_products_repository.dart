import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';

abstract class FavoriteProductsRepository {
  Future<Either<BaseException, void>> addOrRemoveProductToFavorites(
    String productId,
    String userId,
  );
}
