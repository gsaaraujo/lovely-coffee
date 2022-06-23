// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FavoriteProductEntity extends Equatable {
  const FavoriteProductEntity({required this.userId, required this.productId});

  final String userId;
  final String productId;

  @override
  List<Object?> get props => [userId, productId];
}
