import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/event_model.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<EventModel>>> fetchEvents();
}