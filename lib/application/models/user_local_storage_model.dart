import 'package:equatable/equatable.dart';

class UserLocalStorageEntity extends Equatable {
  const UserLocalStorageEntity({
    required this.uid,
    this.imageUrl,
    required this.name,
  });

  final String uid;
  final String? imageUrl;
  final String name;

  factory UserLocalStorageEntity.fromMap(Map<String, dynamic> map) {
    return UserLocalStorageEntity(
      uid: map['uid'] ?? '',
      imageUrl: map['imageUrl'],
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "imageUrl": imageUrl,
      "name": name,
    };
  }

  @override
  List<Object?> get props => [uid, imageUrl, name];
}
