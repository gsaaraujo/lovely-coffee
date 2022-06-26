import 'package:equatable/equatable.dart';

class FavoriteProductEntity extends Equatable {
  const FavoriteProductEntity({
    required this.id,
    required this.userId,
    required this.productId,
  });

  final String id;
  final String userId;
  final String productId;

  @override
  List<Object?> get props => [id];
}
