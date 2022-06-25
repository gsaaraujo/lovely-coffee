import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/modules/auth/external/remote/user_datasource_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/cubits/splash_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/ui/pages/splash_page.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_cubit.dart';
import 'package:lovely_coffee/modules/auth/infra/repositories/user_repository_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/ui/pages/sign_in_page.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_google_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_credentials_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/check_if_user_is_already_signed_in_usecase_impl.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => SplashCubit(i())),
        Bind.lazySingleton((i) => SignInCubit(i(), i(), i(), i())),
        Bind.factory((i) => UserRepositoryImpl(i(), i())),
        Bind.factory((i) => UserDatasourceImpl(i(), i())),
        Bind.factory((i) => SignInWithGoogleUsecaseImpl(i())),
        Bind.factory((i) => SignInWithCredentialsUsecaseImpl(i())),
        Bind.factory((i) => CheckIfUserIsAlreadySignedInUsecaseImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ChildRoute('/sign-in', child: (context, args) => const SignInPage()),
      ];
}
