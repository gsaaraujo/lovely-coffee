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
      final document =
          await _firestore.collection('products').where('', whereIn: []).get();

      final productList =
          document.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

      return productList;
    } catch (exception, stackTrace) {
      throw UnknownException(stackTrace: stackTrace);
    }
  }
}
