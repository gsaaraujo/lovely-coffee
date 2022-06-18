import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lovely_coffee/app/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/app/services/secure_local_storage/secure_local_storage.dart';

class SecureLocalStorageImpl implements SecureLocalStorage {
  SecureLocalStorageImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> addTokens(
    UserSecureLocalStorageModel userSecureLocalStorage,
  ) async {
    _secureStorage.write(
      key: 'USER_TOKENS',
      value: userSecureLocalStorage.toJson(),
    );
  }

  @override
  Future<void> deleteTokens() async {
    _secureStorage.delete(key: 'USER_TOKENS');
  }

  @override
  Future<UserSecureLocalStorageModel?> getTokens() async {
    final String? userTokensJson =
        await _secureStorage.read(key: 'USER_TOKENS');

    if (userTokensJson == null) return null;

    return UserSecureLocalStorageModel.fromJson(userTokensJson);
  }

  @override
  Future<void> updateTokens(
    UserSecureLocalStorageModel userSecureLocalStorage,
  ) async {
    _secureStorage.write(
      key: 'USER_TOKENS',
      value: userSecureLocalStorage.toJson(),
    );
  }
}
