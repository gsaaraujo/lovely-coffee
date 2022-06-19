// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
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

  @override
  List<Object?> get props => [id];
}
