import 'package:equatable/equatable.dart';

class FavoriteProductModel extends Equatable {
  const FavoriteProductModel({
    required this.id,
    required this.userId,
    required this.productId,
  });

  final String id;
  final String userId;
  final String productId;

  factory FavoriteProductModel.fromMap(Map<String, dynamic> map) {
    return FavoriteProductModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
    );
  }

  FavoriteProductModel copyWith({
    String? id,
    String? userId,
    String? productId,
  }) {
    return FavoriteProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
    );
  }

  @override
  List<Object?> get props => [id];
}
