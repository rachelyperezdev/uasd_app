import 'package:uasd_app/core/errors/base_exception.dart';

// excepción de la API
class ApiException extends BaseException {
  ApiException(String message, {int? statusCode})
      : super(message, statusCode: statusCode);

  @override
  String toString() {
    return 'Api Exception: $message (status code: $statusCode)';
  }
}
