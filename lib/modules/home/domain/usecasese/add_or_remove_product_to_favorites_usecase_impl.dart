import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/favorite_products_repository.dart';

abstract class AddOrRemoveProductToFavoritesUsecase {
  Future<Either<BaseException, void>> call(String productId, String userId);
}

class AddOrRemoveProductToFavoritesUsecaseImpl
    implements AddOrRemoveProductToFavoritesUsecase {
  AddOrRemoveProductToFavoritesUsecaseImpl(this._repository);

  final FavoriteProductsRepository _repository;

  @override
  Future<Either<BaseException, void>> call(String productId, String userId) {
    return _repository.addOrRemoveProductToFavorites(productId, userId);
  }
}
