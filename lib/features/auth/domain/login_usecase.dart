import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  // final AuthRepositoryImpl authRepository;
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<Either<Failure, UserModel>> execute(
      String username, String password) async {
    return authRepository.login(username, password);
  }
}
