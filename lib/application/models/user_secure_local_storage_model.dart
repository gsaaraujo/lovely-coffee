import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserSecureLocalStorageEntity extends Equatable {
  const UserSecureLocalStorageEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserSecureLocalStorageEntity.fromMap(Map<String, dynamic> map) {
    return UserSecureLocalStorageEntity(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSecureLocalStorageEntity.fromJson(String source) =>
      UserSecureLocalStorageEntity.fromMap(json.decode(source));

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
