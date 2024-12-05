import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/preselection/domain/get_preselections_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_state.dart';

class DeletePreselectionBloc
    extends Bloc<DeletePreselectionEvent, DeletePreselectionState> {
  final GetPreselectionsUsecase preselectionUsecase;

  DeletePreselectionBloc({required this.preselectionUsecase})
      : super(DeletePreselectionInitial()) {
    on<DeletePreselectionEvent>(_onDeletePreselection);
  }

  Future<void> _onDeletePreselection(DeletePreselectionEvent event,
      Emitter<DeletePreselectionState> emit) async {
    emit(DeletePreselectionLoading());
    final result = await preselectionUsecase.deletePreselection(
        courseCode: event.courseCode);
    result.fold(
      (failure) => emit(DeletePreselectionError(
          message: 'No se pudo cancelar la preselección de la asignatura.')),
      (_) => emit(DeletePreselectionSuccess(
          message: "Asignatura removida de la preselección.",
          courseCode: event.courseCode)),
    );
  }
}
