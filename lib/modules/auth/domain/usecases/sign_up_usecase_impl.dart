import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';

abstract class SignUpUsecase {
  Future<Either<BaseException, void>> call(
    String name,
    String email,
    String password,
  );
}

class SignUpUsecaseImpl implements SignUpUsecase {
  SignUpUsecaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Either<BaseException, void>> call(
    String name,
    String email,
    String password,
  ) {
    return _repository.signUp(name, email, password);
  }
}
