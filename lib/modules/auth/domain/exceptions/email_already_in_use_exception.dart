import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class EmailAlreadyInUseException extends BaseException {
  EmailAlreadyInUseException({
    super.errorMessage,
    super.stackTrace,
  });
}
