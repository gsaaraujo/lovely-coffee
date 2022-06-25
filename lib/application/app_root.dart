import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/application/styles/theme_styles.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0XFFD17843),
        systemNavigationBarColor: Color(0XFFD17843),
      ),
    );

    return MaterialApp.router(
      theme: themeStyles(),
      debugShowCheckedModeBanner: false,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
