import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class PasswordIsTooWeakException extends BaseException {
  PasswordIsTooWeakException({
    super.errorMessage,
    super.stackTrace,
  });
}
