import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/schedule_model.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<ScheduleModel>>> fetchSchedule();
}
