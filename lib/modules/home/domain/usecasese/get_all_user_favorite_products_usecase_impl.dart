import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/domain/entities/favorite_product_entity.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/favorite_products_repository.dart';

abstract class GetAllUserFavoriteProductsUsecase {
  Future<Either<BaseException, List<FavoriteProductEntity>>>
      getAllUserFavoriteProductsUsecase(String userId);
}

class GetAllUserFavoriteProductsUsecaseImpl
    implements GetAllUserFavoriteProductsUsecase {
  GetAllUserFavoriteProductsUsecaseImpl(this._repository);

  final FavoriteProductsRepository _repository;

  @override
  Future<Either<BaseException, List<FavoriteProductEntity>>>
      getAllUserFavoriteProductsUsecase(String userId) {
    return _repository.findAllFavoriteProductsByUserId(userId);
  }
}
