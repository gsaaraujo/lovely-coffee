import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';

abstract class IUserGoogleSignInUsecase {
  Future<Either<BaseFailure, UserSignedInEntity>> call();
}

class UserGoogleSignInUsecaseImpl implements IUserGoogleSignInUsecase {
  UserGoogleSignInUsecaseImpl(this._repository);

  final IUserRepository _repository;

  @override
  Future<Either<BaseFailure, UserSignedInEntity>> call() async {
    return await _repository.googleSignIn();
  }
}
