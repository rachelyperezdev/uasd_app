import 'package:uasd_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<void> execute() async {
    return await authRepository.logout();
  }
}
