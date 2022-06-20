import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class DeviceConnectivityServiceImpl implements DeviceConnectivityService {
  final _connectivity = Connectivity();

  @override
  Future<bool> hasDeviceConnection() async {
    final ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();

    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
