import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/change_password.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/about_user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, UserModel>> fetchUserInfo() async {
    try {
      final response = await apiClient.get('/info_usuario');

      if (response['success']) {
        final userData = UserModel.fromJson(response);

        return Right(userData);
      } else {
        return Left(CustomFailure('Couldn\'t retrieve user data.'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  @override
  Future<Either<Failure, ChangePasswordResponse>> changePassword(
      {required ChangePasswordRequest changePassword}) async {
    try {
      final response = await apiClient.post('/cambiar_password',
          data: jsonEncode(changePassword.toJson()));

      final data = ChangePasswordResponse.fromJson(response);

      if (data.error == 'error') {
        return Left(CustomFailure(data.error));
      }

      return Right(data);
    } catch (error) {
      return _handleError(error);
    }
  }

  Either<Failure, T> _handleError<T>(dynamic error) {
    if (error is NetworkException) {
      return Left(
          NetworkFailure('Network issue, please check your connection.'));
    } else if (error is ServerException) {
      return Left(ServerFailure('Failed to fetch assignments, try again.'));
    } else {
      return Left(CustomFailure('An unexpected error occurred.'));
    }
  }
}
