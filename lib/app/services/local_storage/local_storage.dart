import 'package:lovely_coffee/app/models/user_local_storage_model.dart';

abstract class LocalStorage {
  Future<void> addUser(UserLocalStorageModel userLocalStorage);
  Future<UserLocalStorageModel?> getUser();
  Future<void> deleteUser();
  Future<void> updateUser(UserLocalStorageModel userLocalStorage);
}