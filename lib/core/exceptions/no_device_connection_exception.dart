import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class NoDeviceConnectionException extends BaseException {
  NoDeviceConnectionException({
    super.errorMessage,
    super.label,
    super.stackTrace,
  });
}
