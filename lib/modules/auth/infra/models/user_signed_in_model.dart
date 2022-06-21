import 'dart:convert';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';

class UserSignedInModel extends UserSignedInEntity {
  const UserSignedInModel({
    required super.uid,
    required super.imageUrl,
    required super.name,
    required super.accessToken,
    required super.refreshToken,
  });

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

  factory UserSignedInModel.fromEntity(UserSignedInEntity userSignedInEntity) {
    return UserSignedInModel(
      uid: userSignedInEntity.uid,
      imageUrl: userSignedInEntity.imageUrl,
      name: userSignedInEntity.name,
      accessToken: userSignedInEntity.accessToken,
      refreshToken: userSignedInEntity.refreshToken,
    );
  }

  UserSignedInEntity toEntity() {
    return UserSignedInEntity(
      uid: uid,
      imageUrl: imageUrl,
      name: name,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSignedInModel.fromJson(String source) =>
      UserSignedInModel.fromMap(json.decode(source));
}
