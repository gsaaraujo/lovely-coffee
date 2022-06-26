import 'package:hive/hive.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final HiveInterface _hive = Hive;

  @override
  Future<void> addUser(UserLocalStorageEntity userLocalStorage) async {
    final box = await _hive.openBox('USER_BOX');
    box.put('USER', userLocalStorage.toMap());
  }

  @override
  Future<void> deleteUser() async {
    final box = await _hive.openBox('USER_BOX');
    box.delete('USER');
  }

  @override
  Future<UserLocalStorageEntity> getUser() async {
    final box = await _hive.openBox('USER_BOX');
    final userMap = box.get('USER');

    return UserLocalStorageEntity.fromMap(
      Map<String, dynamic>.from(userMap),
    );
  }

  @override
  Future<void> updateUser(UserLocalStorageEntity userLocalStorage) async {
    final box = await _hive.openBox('USER_BOX');
    box.put('USER', userLocalStorage.toMap());
  }

  @override
  Future<bool> hasUser() async {
    final box = await _hive.openBox('USER_BOX');
    return box.containsKey('USER');
  }
}
