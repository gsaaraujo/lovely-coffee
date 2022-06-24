import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/core/binds/shared_binds.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/ui/pages/splash_page.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/check_if_user_is_already_signed_in_usecase_impl.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [SharedBinds()];

  @override
  List<Bind> get binds => [
        Bind.factory((i) => CheckIfUserIsAlreadySignedInUsecaseImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashPage()),
      ];
}
