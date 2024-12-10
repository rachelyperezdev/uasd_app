import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/core/secure_storage/secure_storage_service.dart';
import 'package:uasd_app/data/models/reset_password_response.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final SecureStorageService secureStorageService;

  AuthRepositoryImpl(
      {required this.apiClient, required this.secureStorageService});

  // Inicio de Sesión
  @override
  Future<Either<Failure, UserModel>> login(
      String username, String password) async {
    try {
      final response = await apiClient
          .post('/login', data: {'username': username, 'password': password});

      final user = UserModel.fromJson(response);
      await secureStorageService.saveToken(user.authToken);

      return Right(user);
    } catch (error) {
      if (error is NetworkException) {
        return Left(
            NetworkFailure('Network issue, please check you connection.'));
      } else if (error is ServerException) {
        return Left(ServerFailure('Failed to reset password, try again.'));
      } else {
        return Left(CustomFailure('An unexpected error ocurred.'));
      }
    }
  }

  // Cierre de sesión
  @override
  Future<void> logout() async {
    await secureStorageService.deleteToken();
  }

  // Restablecer contraseña
  @override
  Future<Either<Failure, ResetPasswordResponseModel>> resetPassword(
      String usuario, String email) async {
    try {
      final response = await apiClient
          .post('/reset_password', data: {'usuario': usuario, 'email': email});

      final resetPasswordResponse =
          ResetPasswordResponseModel.fromJson(response);

      return Right(resetPasswordResponse);
    } catch (error) {
      if (error is NetworkException) {
        return Left(
            NetworkFailure('Network issue, please check you connection.'));
      } else if (error is ServerException) {
        return Left(ServerFailure('Failed to reset password, try again.'));
      } else {
        return Left(CustomFailure('An unexpected error ocurred.'));
      }
    }
  }
}