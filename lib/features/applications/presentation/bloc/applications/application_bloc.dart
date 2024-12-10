import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/applications/domain/application_usecase.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationUsecase applicationUsecase;

  ApplicationBloc({required this.applicationUsecase})
      : super(ApplicationInitial()) {
    on<FetchApplications>(_onFetchApplications);
  }

  Future<void> _onFetchApplications(
      FetchApplications event, Emitter<ApplicationState> emit) async {
    emit(ApplicationLoading()); // cargando

    final result =
        await applicationUsecase.getApplications(); // llama al caso de uso

    // emite
    result.fold(
        (failure) => emit(ApplicationsError(
            message: 'No se pudieron cargar las solicitudes.')),
        (applications) {
      if (applications.isEmpty) {
        emit(NoApplications());
      } else {
        emit(ApplicationsLoaded(applications: applications));
      }
    });
  }
}

