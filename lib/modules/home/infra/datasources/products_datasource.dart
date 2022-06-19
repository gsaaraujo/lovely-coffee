import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';

abstract class ProductsDatasource {
  Future<List<ProductModel>> findAllProducts({String? category});
}
