class UserLocalStorageModel {
  UserLocalStorageModel({
    required this.uid,
    this.imageUrl,
    required this.name,
  });

  final String uid;
  final String? imageUrl;
  final String name;

  factory UserLocalStorageModel.fromMap(Map<String, dynamic> map) {
    return UserLocalStorageModel(
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
}
