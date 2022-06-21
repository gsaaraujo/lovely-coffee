import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';

abstract class SignInWithCredentialsUsecase {
  Future<Either<BaseException, UserSignedInEntity>> call(
    String email,
    String password,
  );
}

class SignInWithCredentialsUsecaseImpl implements SignInWithCredentialsUsecase {
  SignInWithCredentialsUsecaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Either<BaseException, UserSignedInEntity>> call(
    String email,
    String password,
  ) {
    return _repository.signInWithCredentials(email, password);
  }
}
