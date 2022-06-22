import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class InvalidEmailException extends BaseException {
  InvalidEmailException({super.errorMessage, super.stackTrace});
}
