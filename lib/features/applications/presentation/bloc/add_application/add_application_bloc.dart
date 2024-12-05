import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/features/applications/domain/application_usecase.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_state.dart';

class AddApplicationBloc
    extends Bloc<AddApplicationEvent, AddApplicationState> {
  final ApplicationUsecase applicationUsecase;

  AddApplicationBloc({required this.applicationUsecase})
      : super(AddApplicationInitial()) {
    on<AddApplicationEvent>(_addApplication);
  }

  Future<void> _addApplication(
      AddApplicationEvent event, Emitter<AddApplicationState> emit) async {
    emit(AddApplicationLoading()); // cargando

    try {
      final result = await applicationUsecase
          .addApplication(event.addApplication); // invoca caso de uso

      // emite
      result.fold((failure) {
        if (failure is CustomFailure) {
          return emit(AddApplicationError(
              message: 'Lo sentimos, ya existe una solicitud de este tipo'));
        } else {
          return emit(AddApplicationError(
              message:
                  'Lo sentimos, ha ocurrido un error al crear la solicitud.'));
        }
      }, (addedApplication) => emit(AddApplicationLoaded()));
    } catch (error) {
      emit(AddApplicationError(message: 'Ha ocurrido un error inesperado.'));
    }
  }
}
