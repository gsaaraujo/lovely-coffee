import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<BaseException, List<ProductEntity>>> findAllProducts({
    String? filter,
  });
}
