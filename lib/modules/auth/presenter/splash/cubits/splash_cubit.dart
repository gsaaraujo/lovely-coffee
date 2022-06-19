import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/check_if_user_is_already_signed_in_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/cubits/splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit(this._usecase) : super(SplashInitialState());

  final CheckIfUserIsAlreadySignedInUsecase _usecase;

  void redirectUser() async {
    emit(SplashLoadingState());

    final bool hasUser = await _usecase();

    if (hasUser) {
      emit(SplashRedirectToHomeState());
    } else {
      emit(SplashRedirectToSignInState());
    }
  }
}
