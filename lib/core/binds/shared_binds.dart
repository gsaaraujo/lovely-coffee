import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_impl.dart';

class SharedBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<LocalStorage>(
          (i) => LocalStorageImpl(),
          export: true,
        ),
        Bind.lazySingleton<SecureLocalStorage>(
          (i) => SecureLocalStorageImpl(),
          export: true,
        ),
        Bind.lazySingleton(
          (i) => FirebaseAuth.instance,
          export: true,
        ),
        Bind.lazySingleton(
          (i) => GoogleSignIn(),
          export: true,
        ),
      ];
}
