// Excepción del servidor
import 'package:uasd_app/core/errors/api_exception.dart';

class ServerException extends ApiException {
  ServerException(message) : super(message, statusCode: 500);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}
