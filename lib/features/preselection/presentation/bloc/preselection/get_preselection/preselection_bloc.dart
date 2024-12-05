import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/preselection/domain/get_preselections_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_state.dart';

class PreselectionBloc extends Bloc<PreselectionEvent, PreselectionState> {
  final GetPreselectionsUsecase preselectionsUsecase;

  PreselectionBloc({required this.preselectionsUsecase})
      : super(PreselectionInitial()) {
    on<FetchPreselection>(_fetchPreselection);
    on<FetchConfirmedPreselection>(_fetchConfirmedPreselection);
    on<FetchUnconfirmedPreselection>(_fetchUnconfirmedPreselection);
  }

  Future<void> _fetchPreselection(
      FetchPreselection event, Emitter<PreselectionState> emit) async {
    emit(PreselectionLoading());

    final result = await preselectionsUsecase.callPreselection();

    result.fold(
        (failure) => emit(
            PreselectionError(message: 'No se pudo obtener su preselección.')),
        (preselection) {
      if (preselection.isEmpty) {
        return emit(NoPreselection());
      } else {
        return emit(PreselectionLoaded(preselection: preselection));
      }
    });
  }

  Future<void> _fetchConfirmedPreselection(
      FetchConfirmedPreselection event, Emitter<PreselectionState> emit) async {
    emit(PreselectionLoading());

    final result = await preselectionsUsecase.callConfirmedPreselection();

    result.fold(
        (failure) => emit(ConfirmedPreselectionError(
            message: 'No se pudo obtener las asignaturas confirmadas.')),
        (confirmedPreselection) {
      if (confirmedPreselection.isEmpty) {
        return emit(NoPreselection());
      } else {
        return emit(ConfirmedPreselectionLoaded(
            confirmedPreselection: confirmedPreselection));
      }
    });
  }

  Future<void> _fetchUnconfirmedPreselection(FetchUnconfirmedPreselection event,
      Emitter<PreselectionState> emit) async {
    emit(PreselectionLoading());

    final result = await preselectionsUsecase.callUnconfirmedPreselection();

    result.fold(
        (failure) => emit(UnconfirmedPreselectionError(
            message:
                'No se pudo obtener las asignaturas que no han sido confirmadas.')),
        (unconfirmedPreselection) {
      if (unconfirmedPreselection.isEmpty) {
        return emit(NoPreselection());
      } else {
        return emit(UnconfirmedPreselectionLoaded(
            unconfirmedPreselection: unconfirmedPreselection));
      }
    });
  }
}
