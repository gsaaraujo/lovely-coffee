import 'package:equatable/equatable.dart';

class UserSignedInEntity extends Equatable {
  const UserSignedInEntity({
    required this.uid,
    required this.imageUrl,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });

  final String uid;
  final String? imageUrl;
  final String name;
  final String accessToken;
  final String refreshToken;

  @override
  List<Object?> get props => [uid];
}
