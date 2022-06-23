import 'package:lovely_coffee/modules/home/domain/entities/favorite_product_entity.dart';

class FavoriteProductModel extends FavoriteProductEntity {
  const FavoriteProductModel({
    required super.userId,
    required super.productId,
  });

  factory FavoriteProductModel.fromMap(Map<String, dynamic> map) {
    return FavoriteProductModel(
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
    );
  }

  FavoriteProductEntity toEntity() {
    return FavoriteProductEntity(
      userId: userId,
      productId: productId,
    );
  }
}
