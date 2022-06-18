import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_google_sign_in_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/cubits/sign_in_states.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(
    this._usecase,
    this._localStorage,
    this._secureLocalStorage,
  ) : super(SignInInitialState());

  final UserGoogleSignInUsecase _usecase;
  final LocalStorage _localStorage;
  final SecureLocalStorage _secureLocalStorage;

  void googleSignIn() async {
    emit(SignInLoadingState());

    final userSignedInEntity = await _usecase();

    userSignedInEntity.fold(
      (baseFailure) {
        emit(SignInFailedState(message: baseFailure.message));
      },
      (userSignedInEntity) {
        final userLocalStorage = UserLocalStorageModel(
          uid: userSignedInEntity.uid,
          imageUrl: userSignedInEntity.imageUrl,
          name: userSignedInEntity.name,
        );

        final userSecureLocalStorage = UserSecureLocalStorageModel(
          accessToken: userSignedInEntity.accessToken,
          refreshToken: userSignedInEntity.refreshToken,
        );

        _localStorage.addUser(userLocalStorage);
        _secureLocalStorage.addTokens(userSecureLocalStorage);

        emit(SignInSucceedState());
      },
    );
  }
}
