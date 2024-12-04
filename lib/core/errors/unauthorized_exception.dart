// Excepción de no autorizado
import 'package:uasd_app/core/errors/api_exception.dart';

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, statusCode: 401);

  @override
  String toString() {
    return 'UnauthorizedException: $message';
  }
}
