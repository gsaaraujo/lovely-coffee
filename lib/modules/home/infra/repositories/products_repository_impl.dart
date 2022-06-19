import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/application/constants/error_strings.dart';
import 'package:lovely_coffee/core/faults/failures/unexpected_failure.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(this._datasource);

  final ProductsDatasource _datasource;

  @override
  Future<Either<BaseFailure, List<ProductEntity>>> findAllProducts({
    String? category,
  }) async {
    try {
      final List<ProductModel> productList =
          await _datasource.findAllProducts();

      final List<ProductEntity> productListConverted =
          productList.map((product) => product.toEntity()).toList();

      return Right(productListConverted);
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(message: e.message));
    }
  }
}
