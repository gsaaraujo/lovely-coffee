import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';

abstract class UserGoogleSignInUsecase {
  Future<Either<BaseException, UserSignedInEntity>> call();
}

class UserGoogleSignInUsecaseImpl implements UserGoogleSignInUsecase {
  UserGoogleSignInUsecaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Either<BaseException, UserSignedInEntity>> call() async {
    return await _repository.googleSignIn();
  }
}
