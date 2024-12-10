import 'package:uasd_app/core/errors/base_exception.dart';

// Excepción de red
class NetworkException extends BaseException {
  NetworkException(message) : super(message);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}

