import 'package:lovely_coffee/application/services/local_storage/local_storage.dart';

abstract class CheckIfUserIsAlreadySignedInUsecase {
  Future<bool> call();
}

class CheckIfUserIsAlreadySignedInUsecaseImpl
    implements CheckIfUserIsAlreadySignedInUsecase {
  CheckIfUserIsAlreadySignedInUsecaseImpl(this._localStorage);

  final LocalStorage _localStorage;

  @override
  Future<bool> call() async {
    return await _localStorage.hasUser();
  }
}
