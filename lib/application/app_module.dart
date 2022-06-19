import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/core/binds/shared_binds.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/ui/pages/splash_page.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [SharedBinds()];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashPage()),
      ];
}
