import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_google_sign_in_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/cubits/sign_in_states.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(this._usecase) : super(SignInInitialState());

  final UserGoogleSignInUsecase _usecase;

  void googleSignIn() async {
    emit(SignInLoadingState());

    final userSignedInEntity = await _usecase();

    userSignedInEntity.fold(
      (baseFailure) {
        emit(SignInFailedState(message: baseFailure.message));
      },
      (userSignedInEntity) {
        //
      },
    );
  }
}
