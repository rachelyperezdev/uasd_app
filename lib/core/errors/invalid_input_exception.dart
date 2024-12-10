import 'package:uasd_app/core/errors/base_exception.dart';

// Excepción para inputs no válidas
class InvalidInputException extends BaseException {
  InvalidInputException(message) : super(message);

  @override
  String toString() {
    return 'InvalidInputException: $message';
  }
}
