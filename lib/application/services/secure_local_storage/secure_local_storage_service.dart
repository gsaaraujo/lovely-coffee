import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';

abstract class SecureLocalStorageService {
  Future<void> addTokens(UserSecureLocalStorageEntity userSecureLocalStorage);
  Future<UserSecureLocalStorageEntity?> getTokens();
  Future<void> deleteTokens();
  Future<void> updateTokens(
      UserSecureLocalStorageEntity userSecureLocalStorage);
}
