import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/core/binds/app_binds.dart';
import 'package:lovely_coffee/modules/auth/presenter/auth_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [AppBinds()];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AuthModule()),
      ];
}
