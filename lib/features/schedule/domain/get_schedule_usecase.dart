import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/schedule_model.dart';
import 'package:uasd_app/features/schedule/domain/repositories/schedule_repository.dart';

class GetScheduleUsecase {
  final ScheduleRepository scheduleRepository;

  GetScheduleUsecase({required this.scheduleRepository});

  Future<Either<Failure, List<ScheduleModel>>> execute() async {
    return await scheduleRepository.fetchSchedule();
  }
}
