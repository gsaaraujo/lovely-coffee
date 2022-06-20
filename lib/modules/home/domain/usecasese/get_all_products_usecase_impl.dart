// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';

abstract class GetAllProductsUsecase {
  Future<Either<BaseException, List<ProductEntity>>> call({
    String? filter,
  });
}

class GetAllProductsUsecaseImpl implements GetAllProductsUsecase {
  GetAllProductsUsecaseImpl(this._repository);

  final ProductsRepository _repository;

  @override
  Future<Either<BaseException, List<ProductEntity>>> call({
    String? filter,
  }) {
    return _repository.findAllProducts(filter: filter);
  }
}
