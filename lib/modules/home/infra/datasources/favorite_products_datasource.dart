import 'package:lovely_coffee/modules/home/infra/models/favorite_product_model.dart';

abstract class FavoriteProductsDatasource {
  Future<void> addOrRemoveProductToFavorites(String productId, String userId);
  Future<List<FavoriteProductModel>> findAllFavoriteProductsByUserId(
    String userId,
  );
}
