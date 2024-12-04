// Excepción de red
import 'package:uasd_app/core/errors/base_exception.dart';

class NetworkException extends BaseException {
  NetworkException(message) : super(message);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}
