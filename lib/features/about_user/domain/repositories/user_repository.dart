import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/change_password.dart';
import 'package:uasd_app/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> fetchUserInfo();
  Future<Either<Failure, ChangePasswordResponse>> changePassword(
      {required ChangePasswordRequest changePassword});
}
