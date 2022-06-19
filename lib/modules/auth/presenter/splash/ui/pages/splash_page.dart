import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    final client = Modular.get<DeviceConnectivityService>();

    client.hasDeviceConnection().listen((hasConnection) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash.json',
          width: 150,
        ),
      ),
    );
  }
}
