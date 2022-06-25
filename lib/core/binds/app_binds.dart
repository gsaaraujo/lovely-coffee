import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service_impl.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service_impl.dart';

class AppBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<LocalStorageService>(
          (i) => LocalStorageServiceImpl(),
          export: true,
        ),
        Bind.factory<SecureLocalStorageService>(
          (i) => SecureLocalStorageServiceImpl(),
          export: true,
        ),
        Bind.factory<DeviceConnectivityService>(
          (i) => DeviceConnectivityServiceImpl(),
          export: true,
        ),
        Bind.factory(
          (i) => FirebaseAuth.instance,
          export: true,
        ),
        Bind.factory(
          (i) => GoogleSignIn(),
          export: true,
        ),
      ];
}
