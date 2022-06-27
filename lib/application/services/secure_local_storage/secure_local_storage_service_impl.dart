import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';
import 'package:lovely_coffee/core/exceptions/secure_local_storage_exception.dart';

class SecureLocalStorageServiceImpl implements SecureLocalStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<Either<BaseException, void>> addTokens(
    UserSecureLocalStorageEntity userSecureLocalStorage,
  ) async {
    try {
      _secureStorage.write(
        key: 'USER_TOKENS',
        value: userSecureLocalStorage.toJson(),
      );

      return const Right(null);
    } catch (e) {
      return Left(SecureLocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, void>> deleteTokens() async {
    try {
      _secureStorage.delete(key: 'USER_TOKENS');

      return const Right(null);
    } catch (e) {
      return Left(SecureLocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, UserSecureLocalStorageEntity?>>
      getTokens() async {
    try {
      final String? userTokensJson =
          await _secureStorage.read(key: 'USER_TOKENS');

      if (userTokensJson == null) return const Right(null);

      final secureLocalStorage =
          UserSecureLocalStorageEntity.fromJson(userTokensJson);

      return Right(secureLocalStorage);
    } catch (e) {
      return Left(SecureLocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, void>> updateTokens(
    UserSecureLocalStorageEntity userSecureLocalStorage,
  ) async {
    try {
      _secureStorage.write(
        key: 'USER_TOKENS',
        value: userSecureLocalStorage.toJson(),
      );

      return const Right(null);
    } catch (e) {
      return Left(SecureLocalStorageException());
    }
  }
}
