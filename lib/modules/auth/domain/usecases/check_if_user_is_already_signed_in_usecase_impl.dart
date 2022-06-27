import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';

abstract class CheckIfUserIsAlreadySignedInUsecase {
  Future<Either<BaseException, bool>> call();
}

class CheckIfUserIsAlreadySignedInUsecaseImpl
    implements CheckIfUserIsAlreadySignedInUsecase {
  CheckIfUserIsAlreadySignedInUsecaseImpl(this._localStorage);

  final LocalStorageService _localStorage;

  @override
  Future<Either<BaseException, bool>> call() async {
    return await _localStorage.hasUser();
  }
}
