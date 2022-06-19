// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';

abstract class GetAllProductsUsecase {
  Future<Either<BaseFailure, List<ProductEntity>>> call({
    String? category,
  });
}

class GetAllProductsUsecaseImpl implements GetAllProductsUsecase {
  GetAllProductsUsecaseImpl(this._repository);

  final ProductsRepository _repository;

  @override
  Future<Either<BaseFailure, List<ProductEntity>>> call({
    String? category,
  }) {
    return _repository.findAllProducts(category: category);
  }
}
