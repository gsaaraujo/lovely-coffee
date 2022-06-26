import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/favorite_product_model.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/favorite_products_datasource.dart';

class FavoriteProductsDatasourceImpl implements FavoriteProductsDatasource {
  FavoriteProductsDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> addOrRemoveProductToFavorites(
      String productId, String userId) async {
    try {
      final Map<String, dynamic> data = {
        "producId": productId,
        "userId": userId,
      };

      final documents = await _firestore
          .collection('favorite-products')
          .where('userId', isEqualTo: userId)
          .where('producId', isEqualTo: productId)
          .get();

      if (documents.docs.isEmpty) {
        await _firestore.collection('favorite-products').add(data);
        return;
      }

      await documents.docs.first.reference.delete();
    } catch (exception, stackTrace) {
      throw UnknownException(stackTrace: stackTrace);
    }
  }

  @override
  Future<List<FavoriteProductModel>> findAllFavoriteProductsByUserId(
      String userId) async {
    try {
      final documents = await _firestore
          .collection('favorite-products')
          .where('userId', isEqualTo: userId)
          .get();

      final favoriteProductList = documents.docs.map((doc) {
        FavoriteProductModel productModel =
            FavoriteProductModel.fromMap(doc.data());

        productModel = productModel.copyWith(id: doc.id);

        return productModel;
      }).toList();

      return favoriteProductList;
    } catch (exception, stackTrace) {
      throw UnknownException(stackTrace: stackTrace);
    }
  }
}
