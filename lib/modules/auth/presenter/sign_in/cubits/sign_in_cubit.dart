import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_states.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_google_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_credentials_usecase_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(
    this._googleSignInUsecase,
    this._emailPasswordUsecase,
    this._localStorage,
    this._secureLocalStorage,
  ) : super(SignInInitialState());

  final SignInWithGoogleUsecase _googleSignInUsecase;
  final SignInWithCredentialsUsecase _emailPasswordUsecase;
  final LocalStorageService _localStorage;
  final SecureLocalStorageService _secureLocalStorage;

  void googleSignIn() async {
    emit(SignInLoadingState());

    final userSignedInEntity = await _googleSignInUsecase();

    userSignedInEntity.fold(
      (exception) {
        if (exception is AuthException) {
          emit(SignInFailedState(message: ExceptionMessagesConst.auth));
          return;
        }

        if (exception is NoDeviceConnectionException) {
          emit(SignInFailedState(message: ExceptionMessagesConst.noConnection));
          return;
        }

        if (exception is UnknownException) {
          emit(SignInFailedState(message: ExceptionMessagesConst.unknown));
          return;
        }
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

  void signInWithCredentials(String email, String password) async {
    emit(SignInLoadingState());

    final userSignedInEntity = await _emailPasswordUsecase(email, password);

    userSignedInEntity.fold(
      (exception) {
        if (exception is InvalidCredentialsException) {
          emit(SignInFailedState(
            message: ExceptionMessagesConst.incorrectCredentials,
          ));
          return;
        }

        if (exception is InvalidEmailException) {
          emit(SignInFailedState(message: ExceptionMessagesConst.invalidEmail));
          return;
        }

        if (exception is NoDeviceConnectionException) {
          emit(SignInFailedState(message: ExceptionMessagesConst.noConnection));
          return;
        }

        if (exception is UnknownException) {
          emit(SignInFailedState(message: ExceptionMessagesConst.unknown));
          return;
        }
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
