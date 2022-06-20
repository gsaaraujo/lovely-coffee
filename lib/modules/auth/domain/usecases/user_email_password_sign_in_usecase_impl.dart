import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';

abstract class UserEmailPasswordSignInUsecase {
  Future<Either<BaseException, UserSignedInEntity>> call(
    String email,
    String password,
  );
}

class UserEmailPasswordSignInUsecaseImpl
    implements UserEmailPasswordSignInUsecase {
  UserEmailPasswordSignInUsecaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Either<BaseException, UserSignedInEntity>> call(
    String email,
    String password,
  ) {
    return _repository.emailPasswordSignIn(email, password);
  }
}
