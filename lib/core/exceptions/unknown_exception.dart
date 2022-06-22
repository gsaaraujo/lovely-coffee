import 'package:lovely_coffee/core/exceptions/base_exception.dart';

class UnknownException extends BaseException {
  UnknownException({super.errorMessage, super.stackTrace});
}
