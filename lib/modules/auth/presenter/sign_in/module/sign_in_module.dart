import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/modules/auth/external/remote/user_datasource_impl.dart';
import 'package:lovely_coffee/modules/auth/infra/repositories/user_repository_impl.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/ui/pages/sign_in_page.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_google_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_credentials_usecase_impl.dart';

class SignInModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => UserRepositoryImpl(i(), i())),
        Bind.factory((i) => UserDatasourceImpl(i(), i())),
        Bind.factory((i) => SignInWithGoogleUsecaseImpl(i())),
        Bind.factory((i) => SignInWithCredentialsUsecaseImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/sign-in', child: (_, args) => const SignInPage()),
      ];
}
