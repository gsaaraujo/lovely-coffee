import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class InvalidCredentialsException extends BaseException {
  InvalidCredentialsException({
    super.errorMessage,
    super.label,
    super.stackTrace,
  });
}
