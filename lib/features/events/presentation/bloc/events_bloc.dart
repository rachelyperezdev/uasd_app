import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/event_model.dart';
import 'package:uasd_app/features/events/domain/get_events_usecase.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_event.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEventsUsecase eventsUsecase;

  EventsBloc({required this.eventsUsecase}) : super(EventsInitial()) {
    on<FetchEvents>(_fetchEvents);
  }

  void _fetchEvents(FetchEvents event, Emitter<EventsState> emit) async {
    emit(EventsLoading()); // cargando

    final Either<Failure, List<EventModel>> result =
        await eventsUsecase.execute(); // llama al caso de uso

    // emite estado
    emit(result.fold(
        (failure) =>
            EventsError(message: 'No se pudieron obtener los eventos.'),
        (events) => EventsLoaded(events: events)));
  }
}