import 'package:dio/dio.dart';
import 'package:uasd_app/core/errors/api_exception.dart';
import 'package:uasd_app/core/errors/unauthorized_exception.dart';
import 'package:uasd_app/core/secure_storage/secure_storage_service.dart';

class ApiClient {
  final Dio dio;
  final SecureStorageService secureStorageService;
  final String baseUrl;

  ApiClient(
      {required this.dio,
      required this.secureStorageService,
      required this.baseUrl}) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = Duration(seconds: 5000);
    dio.options.receiveTimeout = Duration(seconds: 3000);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // Agregar tokens a los headers si esté disponible
      final token = await secureStorageService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options); // procede con el request
    }, onResponse: (response, handler) {
      // Maneja las respuestas
      return handler.next(response);
    }, onError: (DioException exception, handler) {
      if (exception.type == DioExceptionType.badResponse) {
        if (exception.response?.statusCode == 401) {
          throw UnauthorizedException('Unauthorized: Please log in again.');
        }
      }
      return handler.next(exception); // propaga el error
    }));
  }

  // GET request (generico)
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return _handleResponse(response);
    } catch (e) {
      throw _handleException(e);
    }
  }

  // POST request (generico)
  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
      );
      return _handleResponse(response);
    } catch (e) {
      print(e);
      throw _handleException(e);
    }
  }

  // PUT request (generico), no lo usaremos
  Future<dynamic> put(String endpoint, Map<String, dynamic>? data) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // DELETE request (generico), no lo usaremos
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await dio.delete(endpoint);
      return _handleResponse(response);
    } catch (e) {
      throw _handleException(e);
    }
  }

  // Maneja las respuestas de la API
  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data != null) {
        return response.data;
      } else {
        return null;
      }
    } else {
      throw ApiException('Failed to load data: ${response.statusCode}');
    }
  }

  // Maneja los errores
  Exception _handleException(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return ApiException('Request was cancelled');
        case DioExceptionType.connectionTimeout:
          return ApiException('Connection timeout');
        case DioExceptionType.sendTimeout:
          return ApiException('Send timeout');
        case DioExceptionType.receiveTimeout:
          return ApiException('Receive timeout');
        case DioExceptionType.badResponse:
          return ApiException(
              'Received invalid status code: ${error.response?.statusCode}');
        case DioExceptionType.unknown:
          return ApiException('Network error or other issue');
        default:
          return ApiException('An unknown error ocurred');
      }
    } else {
      return ApiException('An unknown error occured');
    }
  }
}
