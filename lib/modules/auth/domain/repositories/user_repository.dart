import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';

abstract class UserRepository {
  Future<Either<BaseException, UserSignedInEntity>> signInWithGoogle();

  Future<Either<BaseException, UserSignedInEntity>> signInWithCredentials(
    String email,
    String password,
  );
}
