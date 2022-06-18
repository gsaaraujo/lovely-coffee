import 'package:lovely_coffee/app/models/user_secure_local_storage_model.dart';

abstract class SecureLocalStorage {
  Future<void> addTokens(UserSecureLocalStorageModel userSecureLocalStorage);
  Future<UserSecureLocalStorageModel?> getTokens();
  Future<void> deleteTokens();
  Future<void> updateTokens(UserSecureLocalStorageModel userSecureLocalStorage);
}
