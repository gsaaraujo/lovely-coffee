import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserSecureLocalStorageModel extends Equatable {
  const UserSecureLocalStorageModel({
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

  factory UserSecureLocalStorageModel.fromMap(Map<String, dynamic> map) {
    return UserSecureLocalStorageModel(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSecureLocalStorageModel.fromJson(String source) =>
      UserSecureLocalStorageModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
