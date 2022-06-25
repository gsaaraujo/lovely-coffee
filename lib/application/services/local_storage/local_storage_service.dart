import 'package:lovely_coffee/application/models/user_local_storage_model.dart';

abstract class LocalStorageService {
  Future<void> addUser(UserLocalStorageEntity userLocalStorage);
  Future<UserLocalStorageEntity> getUser();
  Future<void> deleteUser();
  Future<void> updateUser(UserLocalStorageEntity userLocalStorage);
  Future<bool> hasUser();
}
