import 'package:uasd_app/core/errors/api_exception.dart';

// Excepción de no autorizado
class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, statusCode: 401);

  @override
  String toString() {
    return 'UnauthorizedException: $message';
  }
}
