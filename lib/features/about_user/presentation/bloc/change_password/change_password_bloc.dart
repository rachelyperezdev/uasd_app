import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/about_user/domain/get_userData_usecase.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_event.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final GetUserdataUsecase userdataUsecase;

  ChangePasswordBloc({required this.userdataUsecase})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordButtonPressed>(_onResetPasswordButtonPressed);
  }

  Future<void> _onResetPasswordButtonPressed(ChangePasswordButtonPressed event,
      Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading()); // cargando

    // llama al caso de uso
    final result =
        await userdataUsecase.callChangePassword(request: event.request);

    // emisión de estados
    result.fold(
        (failure) => emit(ChangePasswordFailure(
            message: failure.message ??
                'Ocurrió un error y no se pudo camibar la contraseña')),
        (changedPassword) {
      return emit(ChangePasswordSuccess(message: changedPassword.message));
    });
  }
}
