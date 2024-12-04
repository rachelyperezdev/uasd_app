// Excepción para inputs no válidas
import 'package:uasd_app/core/errors/base_exception.dart';

class InvalidInputException extends BaseException {
  InvalidInputException(message) : super(message);

  @override
  String toString() {
    return 'InvalidInputException: $message';
  }
}
