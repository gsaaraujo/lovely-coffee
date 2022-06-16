import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';

abstract class IUserRepository {
  Future<Either<BaseFailure, UserSignedInEntity>> googleSignIn();
}
