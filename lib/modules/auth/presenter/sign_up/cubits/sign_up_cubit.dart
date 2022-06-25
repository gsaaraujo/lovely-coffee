import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_up_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_up/cubits/sign_up_states.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/email_already_in_use_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/password_is_too_weak_exception.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this._signUpUsecase) : super(SignUpInitialState());

  final SignUpUsecase _signUpUsecase;

  void signUp(String name, String email, String password) async {
    emit(SignUpLoadingState());

    final response = await _signUpUsecase(name, email, password);

    response.fold((exception) {
      if (exception is InvalidEmailException) {
        emit(SignUpFailedState(message: ExceptionMessagesConst.invalidEmail));
        return;
      }

      if (exception is EmailAlreadyInUseException) {
        emit(SignUpFailedState(
            message: ExceptionMessagesConst.emailAlreadyTaken));
        return;
      }

      if (exception is PasswordIsTooWeakException) {
        emit(SignUpFailedState(message: ExceptionMessagesConst.weakPassword));
        return;
      }

      if (exception is NoDeviceConnectionException) {
        emit(SignUpFailedState(message: ExceptionMessagesConst.noConnection));
        return;
      }

      if (exception is UnknownException) {
        emit(SignUpFailedState(message: ExceptionMessagesConst.unknown));
        return;
      }
    }, (r) {
      emit(SignUpSucceedState());
    });
  }
}
