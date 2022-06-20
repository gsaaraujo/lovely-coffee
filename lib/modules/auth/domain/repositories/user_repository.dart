import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';

abstract class UserRepository {
  Future<Either<BaseException, UserSignedInEntity>> googleSignIn();
}
