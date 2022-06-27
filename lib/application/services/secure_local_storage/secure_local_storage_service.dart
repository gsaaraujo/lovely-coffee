import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';

abstract class SecureLocalStorageService {
  Future<Either<BaseException, void>> addTokens(
      UserSecureLocalStorageEntity userSecureLocalStorage);
  Future<Either<BaseException, UserSecureLocalStorageEntity?>> getTokens();
  Future<Either<BaseException, void>> deleteTokens();
  Future<Either<BaseException, void>> updateTokens(
      UserSecureLocalStorageEntity userSecureLocalStorage);
}
