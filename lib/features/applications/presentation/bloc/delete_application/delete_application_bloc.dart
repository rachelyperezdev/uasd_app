import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/applications/domain/application_usecase.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_state.dart';

class DeleteApplicationBloc
    extends Bloc<DeleteApplicationEvent, DeleteApplicationState> {
  final ApplicationUsecase applicationUsecase;

  DeleteApplicationBloc({required this.applicationUsecase})
      : super(DeleteApplicationInitial()) {
    on<DeleteApplicationEvent>(_onDeleteApplication);
  }

  Future<void> _onDeleteApplication(DeleteApplicationEvent event,
      Emitter<DeleteApplicationState> emit) async {
    emit(DeleteApplicationLoading()); // cargando
    final result = await applicationUsecase.deleteApplication(
        applicationId: event.applicationId); // llama al caso de uso

    // emite
    result.fold(
      (failure) => emit(
          DeleteApplicationError(message: 'No se pudo cancelar la solicitud.')),
      (_) => emit(DeleteApplicationSuccess(
          message: "Solicitud cancelada.", applicationId: event.applicationId)),
    );
  }
}
