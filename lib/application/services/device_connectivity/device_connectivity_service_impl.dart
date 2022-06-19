import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class DeviceConnectivityServiceImpl implements DeviceConnectivityService {
  final _connectivity = Connectivity();

  @override
  Stream<bool> hasDeviceConnection() async* {
    _connectivity.onConnectivityChanged.map((connectivityResult) {
      return connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile;
    });
  }
}
