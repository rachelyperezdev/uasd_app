import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/features/preselection/domain/get_preselections_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_state.dart';

class AddPreselectionBloc
    extends Bloc<AddPreselectionEvent, AddPreselectionState> {
  final GetPreselectionsUsecase preselectionUsecase;

  AddPreselectionBloc({required this.preselectionUsecase})
      : super(AddPreselectionInitial()) {
    on<AddPreselectionEvent>(_addPreselection);
  }

  Future<void> _addPreselection(
      AddPreselectionEvent event, Emitter<AddPreselectionState> emit) async {
    emit(AddPreselectionLoading());

    try {
      final result =
          await preselectionUsecase.addPreselection(event.addPreselection);

      result.fold((failure) {
        if (failure is CustomFailure) {
          if (failure.message == "La materia ya está preseleccionada") {
            return emit(AddPreselectionError(
                message: 'La asignatura ya está preseleccionada'));
          }
          return emit(AddPreselectionError(
              message:
                  'Lo sentimos, no se ha podido preseleccionar la asignatura.'));
        } else {
          return emit(AddPreselectionError(
              message:
                  'Lo sentimos, ha ocurrido un error al preseleccionar la asignatura.'));
        }
      }, (addedApplication) => emit(AddPreselectionLoaded()));
    } catch (error) {
      emit(AddPreselectionError(message: 'Ha ocurrido un error inesperado.'));
    }
  }
}