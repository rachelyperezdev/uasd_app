import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/applications/domain/application_usecase.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_state.dart';

class ApplicationTypesBloc
    extends Bloc<ApplicationTypesEvent, ApplicationTypesState> {
  final ApplicationUsecase applicationUsecase;

  ApplicationTypesBloc({required this.applicationUsecase})
      : super(ApplicationTypesInitial()) {
    on<FetchApplicationTypes>(_fetchApplicationTypes);
  }

  Future<void> _fetchApplicationTypes(
      FetchApplicationTypes event, Emitter<ApplicationTypesState> emit) async {
    emit(ApplicationTypesLoading()); // cargando

    final result =
        await applicationUsecase.getApplicationTypes(); // llama al caso de uso

    // emite
    result.fold(
        (failure) => emit(
            ApplicationTypesError(message: "No existen tipos de solicitudes.")),
        (applicationTypes) {
      if (applicationTypes.isEmpty) {
        return emit(NoApplicationTypes());
      } else {
        return emit(ApplicationTypesLoaded(applicationTypes: applicationTypes));
      }
    });
  }
}
