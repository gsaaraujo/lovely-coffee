import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<BaseFailure, List<ProductEntity>>> findAllProducts({
    String? category,
  });
}
