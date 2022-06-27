import 'package:hive/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/local_storage_exception.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final HiveInterface _hive = Hive;

  @override
  Future<Either<BaseException, void>> addUser(
      UserLocalStorageEntity userLocalStorage) async {
    try {
      final box = await _hive.openBox('USER_BOX');
      box.put('USER', userLocalStorage.toMap());

      return const Right(null);
    } catch (e) {
      return Left(LocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, void>> deleteUser() async {
    try {
      final box = await _hive.openBox('USER_BOX');
      box.delete('USER');

      return const Right(null);
    } catch (e) {
      return Left(LocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, UserLocalStorageEntity>> getUser() async {
    try {
      final box = await _hive.openBox('USER_BOX');
      final userMap = box.get('USER');

      final UserLocalStorageEntity userLocalStorageEntity =
          UserLocalStorageEntity.fromMap(
        Map<String, dynamic>.from(userMap),
      );

      return Right(userLocalStorageEntity);
    } catch (e) {
      return Left(LocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, void>> updateUser(
    UserLocalStorageEntity userLocalStorage,
  ) async {
    try {
      final box = await _hive.openBox('USER_BOX');
      box.put('USER', userLocalStorage.toMap());

      return const Right(null);
    } catch (e) {
      return Left(LocalStorageException());
    }
  }

  @override
  Future<Either<BaseException, bool>> hasUser() async {
    try {
      final box = await _hive.openBox('USER_BOX');

      return Right(box.containsKey('USER'));
    } catch (e) {
      return Left(LocalStorageException());
    }
  }
}
