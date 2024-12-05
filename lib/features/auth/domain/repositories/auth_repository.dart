import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/reset_password_response.dart';
import 'package:uasd_app/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login(String username, String password);
  Future<Either<Failure, ResetPasswordResponseModel>> resetPassword(
      String usuario, String email);
  Future<void> logout();
}
