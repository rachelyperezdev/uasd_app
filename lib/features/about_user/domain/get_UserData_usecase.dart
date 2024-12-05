import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/change_password.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/features/about_user/domain/repositories/user_repository.dart';

class GetUserdataUsecase {
  final UserRepository userRepository;

  GetUserdataUsecase({required this.userRepository});

  Future<Either<Failure, UserModel>> execute() async {
    return await userRepository.fetchUserInfo();
  }

  Future<Either<Failure, ChangePasswordResponse>> callChangePassword(
      {required ChangePasswordRequest request}) async {
    return await userRepository.changePassword(changePassword: request);
  }
}
