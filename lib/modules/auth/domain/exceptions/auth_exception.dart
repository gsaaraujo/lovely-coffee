import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class AuthException extends BaseException {
  AuthException({super.errorMessage, super.label, super.stackTrace});
}
