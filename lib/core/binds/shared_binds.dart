import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service_impl.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service_impl.dart';

class SharedBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<LocalStorageService>(
          (i) => LocalStorageServiceImpl(),
          export: true,
        ),
        Bind.lazySingleton<SecureLocalStorageService>(
          (i) => SecureLocalStorageServiceImpl(),
          export: true,
        ),
        Bind.lazySingleton<DeviceConnectivityService>(
          (i) => DeviceConnectivityServiceImpl(),
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
