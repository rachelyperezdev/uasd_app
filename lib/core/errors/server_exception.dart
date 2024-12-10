import 'package:uasd_app/core/errors/api_exception.dart';

// Excepción del servidor
class ServerException extends ApiException {
  ServerException(message) : super(message, statusCode: 500);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}
