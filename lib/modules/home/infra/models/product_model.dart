import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.imageUrl,
    required super.name,
    required super.additionalInfo,
    required super.description,
    required super.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      additionalInfo: map['additionalInfo'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] != null ? map['price'] / 100 : 0.0,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      imageUrl: imageUrl,
      name: name,
      additionalInfo: additionalInfo,
      description: description,
      price: price,
    );
  }
}
