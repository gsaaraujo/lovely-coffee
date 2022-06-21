import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';

abstract class SignInWithGoogleUsecase {
  Future<Either<BaseException, UserSignedInEntity>> call();
}

class SignInWithGoogleUsecaseImpl implements SignInWithGoogleUsecase {
  SignInWithGoogleUsecaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Either<BaseException, UserSignedInEntity>> call() async {
    return await _repository.signInWithGoogle();
  }
}
