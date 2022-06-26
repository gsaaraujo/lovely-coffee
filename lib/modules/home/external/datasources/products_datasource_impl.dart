import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  ProductsDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<ProductModel>> findAllProducts({String? filter}) async {
    try {
      Query<Map<String, dynamic>> document = _firestore.collection('products');

      if (filter != null) {
        document = document.where(filter);
      }

      final documentGet = await document.get();

      final productList = documentGet.docs.map((doc) {
        ProductModel productModel = ProductModel.fromMap(doc.data());

        productModel = productModel.copyWith(id: doc.id);

        return productModel;
      }).toList();

      return productList;
    } catch (exception, stackTrace) {
      throw UnknownException(stackTrace: stackTrace);
    }
  }
}
