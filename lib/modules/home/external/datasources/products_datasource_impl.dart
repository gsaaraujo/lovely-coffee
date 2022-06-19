// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
// import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';

// class ProductsDatasourceImpl implements ProductsDatasource {
//   ProductsDatasourceImpl(this._firestore);

//   final FirebaseFirestore _firestore;

//   @override
//   Future<List<ProductModel>> findAllProducts({String? category}) async {
//     try {
//       final document = await _firestore.collection('products').doc().get();
//     } catch (e) {}
//   }
// }
