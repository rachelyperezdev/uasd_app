import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/features/auth/domain/reset_password_usecase.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUsecase resetPasswordUsecase;

  ResetPasswordBloc({required this.resetPasswordUsecase})
      : super(ResetPasswordInitial()) {
    on<ResetPasswordButtonPressed>(_onResetPasswordPressedButton);
  }

  Future<void> _onResetPasswordPressedButton(ResetPasswordButtonPressed event,
      Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoading()); // cargando

    // llama al caso de uso
    final result = await resetPasswordUsecase.call(event.usuario, event.email);

    // emite
    result.fold((failure) {
      emit(ResetPasswordFailure(error: _mapFailureToMessage(failure)));
    }, (response) {
      if (response.success) {
        emit(ResetPasswordSuccess(message: response.message));
      } else {
        emit(ResetPasswordFailure(
            error: response.error ?? 'Usuario o correo incorrectos'));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Error de red, por favor verifique su conexión.';
    } else if (failure is ServerFailure) {
      return 'Error al cambiar su contraseña. Verifique sus credenciales.';
    } else {
      return 'Error inesperado.';
    }
  }
}
