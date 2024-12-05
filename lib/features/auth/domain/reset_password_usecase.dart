import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/reset_password_response.dart';
import 'package:uasd_app/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository authRepository;

  ResetPasswordUsecase(this.authRepository);

  Future<Either<Failure, ResetPasswordResponseModel>> call(
      String usuario, String email) async {
    return await authRepository.resetPassword(usuario, email);
  }
}
