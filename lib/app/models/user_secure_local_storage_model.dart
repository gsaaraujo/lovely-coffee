// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSecureLocalStorageModel {
  UserSecureLocalStorageModel({
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
}
