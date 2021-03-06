import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lovely_coffee/firebase_options.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/application/app_root.dart';
import 'package:lovely_coffee/application/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ModularApp(module: AppModule(), child: const AppRoot()));
}
