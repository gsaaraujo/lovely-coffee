import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(this._productsDatasource, this._connectivityService);

  final ProductsDatasource _productsDatasource;
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

      final List<ProductModel> productList =
          await _productsDatasource.findAllProducts();

      final List<ProductEntity> productListConverted =
          productList.map((product) => product.toEntity()).toList();

      return Right(productListConverted);
    } on BaseException catch (exception) {
      return Left(exception);
    }
  }
}
