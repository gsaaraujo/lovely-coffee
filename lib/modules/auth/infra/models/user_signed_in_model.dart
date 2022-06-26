import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserSignedInModel extends Equatable {
  const UserSignedInModel({
    required this.uid,
    this.imageUrl,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });

  final String uid;
  final String? imageUrl;
  final String name;
  final String accessToken;
  final String refreshToken;

  factory UserSignedInModel.fromMap(Map map) {
    return UserSignedInModel(
      uid: map['uid'] ?? '',
      imageUrl: map['imageUrl'],
      name: map['name'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'imageUrl': imageUrl,
      'name': name,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserSignedInModel.fromJson(String source) =>
      UserSignedInModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [uid];
}
