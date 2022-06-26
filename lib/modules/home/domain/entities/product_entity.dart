import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.additionalInfo,
    required this.description,
    required this.price,
    required this.isFavorite,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String additionalInfo;
  final String description;
  final double price;
  final bool isFavorite;

  @override
  List<Object?> get props => [id];
}
