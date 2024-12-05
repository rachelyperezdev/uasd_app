import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/auth/domain/logout_usecase.dart';
import 'package:uasd_app/features/auth/presentation/bloc/logout/logout_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/logout/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUsecase logoutUsecase;

  LogoutBloc({required this.logoutUsecase}) : super(LogoutInitial()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading()); // cargando

    try {
      await logoutUsecase.execute(); // llama al caso de uso
      // emite
      emit(LogoutSuccess());
    } catch (error) {
      // emite
      emit(LogoutFailure(error: 'Error al cerrar sesión.'));
    }
  }
}
