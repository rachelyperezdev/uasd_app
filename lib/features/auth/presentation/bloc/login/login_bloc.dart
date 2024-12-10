import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/auth/domain/login_usecase.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final ApiClient apiClient;

  LoginBloc({required this.loginUsecase, required this.apiClient})
      : super(LoginInitial()) {
    on<LogingButtonPressed>(_onLoggingButtonPressed);
  }

  Future<void> _onLoggingButtonPressed(
      LogingButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading()); // cargando

    // llama al caso de uso
    final result = await loginUsecase.execute(event.username, event.password);

    // emite
    await result.fold((failure) {
      emit(LoginFailure(error: _mapFailureToMessage(failure)));
    }, (user) async {
      try {
        final response = await apiClient.get(AppConstants.userInfoRoute);
        final updatedUser = UserModel.fromJson(response);

        emit(LoginSuccess(user: updatedUser));
      } catch (error) {
        emit(LoginFailure(
            error: 'Error al obtener la información del usuario.'));
      }

      emit(LoginSuccess(user: user));
    });
  }

  // Mapea mensajes de error
  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Error de red, por favor verifique su conexión.';
    } else if (failure is ServerFailure) {
      return 'Credenciales incorrectas, por favor trate de nuevo.';
    } else {
      return 'Usuario o contraseña incorrectos.';
    }
  }
}