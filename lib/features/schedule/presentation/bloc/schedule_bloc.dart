import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/schedule/domain/get_schedule_usecase.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetScheduleUsecase scheduleUsecase;

  ScheduleBloc({required this.scheduleUsecase}) : super(ScheduleInitial()) {
    on<FetchSchedules>(_onFetchSchedules);
  }

  Future<void> _onFetchSchedules(
      FetchSchedules event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading()); // carga

    final result = await scheduleUsecase.execute(); // llama al caso de uso

    // emite
    result.fold(
        (failure) => emit(ScheduleError(
            message: 'Lo sentimos, no pudimos obtener sus horarios.')),
        (schedules) {
      if (schedules.isEmpty) {
        return emit(NoSchedules());
      } else {
        return emit(ScheduleLoaded(schedules: schedules));
      }
    });
  }
}

