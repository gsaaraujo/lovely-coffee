import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_states.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_google_sign_in_usecase_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(
    this._usecase,
    this._localStorage,
    this._secureLocalStorage,
  ) : super(SignInInitialState());

  final UserGoogleSignInUsecase _usecase;
  final LocalStorageService _localStorage;
  final SecureLocalStorageService _secureLocalStorage;

  void googleSignIn() async {
    emit(SignInLoadingState());

    final userSignedInEntity = await _usecase();

    userSignedInEntity.fold(
      (exception) {
        emit(SignInFailedState(message: ExceptionMessagesConst.auth));
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
