import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';

abstract class LocalStorageService {
  Future<Either<BaseException, void>> addUser(
      UserLocalStorageEntity userLocalStorage);

  Future<Either<BaseException, UserLocalStorageEntity>> getUser();

  Future<Either<BaseException, void>> deleteUser();

  Future<Either<BaseException, void>> updateUser(
      UserLocalStorageEntity userLocalStorage);

  Future<Either<BaseException, bool>> hasUser();
}
