import 'package:uasd_app/core/errors/base_exception.dart';

// token expirado
class AuthenticationException extends BaseException {
  AuthenticationException(message) : super(message);

  @override
  String toString() {
    return 'AuthenticationException: $message';
  }
}
