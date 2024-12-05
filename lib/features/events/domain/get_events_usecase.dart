import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/event_model.dart';
import 'package:uasd_app/features/events/domain/repositories/events_repository.dart';

class GetEventsUsecase {
  final EventsRepository eventsRepository;

  GetEventsUsecase({required this.eventsRepository});

  Future<Either<Failure, List<EventModel>>> execute() async {
    return await eventsRepository.fetchEvents();
  }
}