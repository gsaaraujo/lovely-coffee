abstract class FavoriteProductsDatasource {
  Future<void> addOrRemoveProductToFavorites(String productId, String userId);
}
