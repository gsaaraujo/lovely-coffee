import 'package:hive/hive.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final HiveInterface _hive = Hive;

  @override
  Future<void> addUser(UserLocalStorageModel userLocalStorage) async {
    final box = await _hive.openBox('USER_BOX');
    box.put('USER', userLocalStorage.toMap());
  }

  @override
  Future<void> deleteUser() async {
    final box = await _hive.openBox('USER_BOX');
    box.delete('USER');
  }

  @override
  Future<UserLocalStorageModel?> getUser() async {
    final box = await _hive.openBox('USER_BOX');
    final Map<String, dynamic>? userMap = box.get('USER');

    if (userMap == null) return null;

    return UserLocalStorageModel.fromMap(userMap);
  }

  @override
  Future<void> updateUser(UserLocalStorageModel userLocalStorage) async {
    final box = await _hive.openBox('USER_BOX');
    box.put('USER', userLocalStorage.toMap());
  }

  @override
  Future<bool> hasUser() async {
    final box = await _hive.openBox('USER_BOX');
    return box.containsKey('USER');
  }
}
