import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.additionalInfo,
    required this.description,
    required this.price,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String additionalInfo;
  final String description;
  final double price;

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      additionalInfo: map['additionalInfo'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
    );
  }

  ProductModel copyWith({
    String? id,
    String? imageUrl,
    String? name,
    String? additionalInfo,
    String? description,
    double? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id];
}
