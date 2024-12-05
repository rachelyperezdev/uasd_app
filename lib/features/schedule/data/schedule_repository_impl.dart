import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/schedule_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/schedule/domain/repositories/schedule_repository.dart';

// Horario
class ScheduleRepositoryImpl extends ScheduleRepository {
  final ApiClient apiClient;
  final int registeredUserId;

  ScheduleRepositoryImpl(
      {required this.apiClient, required this.registeredUserId});

  // Busca los horarios
  @override
  Future<Either<Failure, List<ScheduleModel>>> fetchSchedule() async {
    try {
      final response = await apiClient.get('/horarios');

      final List<dynamic> data = response as List<dynamic>;

      final List<ScheduleModel> schedules =
          data.map((schedule) => ScheduleModel.toJson(schedule)).toList();

      final List<ScheduleModel> mySchedules =
          _filterUserSchedule(schedules); // filtra por usuario

      return Right(mySchedules);
    } catch (error) {
      return _handleError(error);
    }
  }

  // Filtra los horarios por usuario, ya que la API devuelve todos los horarios
  // de todos los estudiantes
  List<ScheduleModel> _filterUserSchedule(List<ScheduleModel> schedules) {
    return schedules
        .where((schedule) => schedule.userId == registeredUserId)
        .toList();
  }

  Either<Failure, T> _handleError<T>(dynamic error) {
    if (error is NetworkException) {
      return Left(
          NetworkFailure('Network issue, please check your connection.'));
    } else if (error is ServerException) {
      return Left(ServerFailure('Failed to fetch assignments, try again.'));
    } else {
      return Left(CustomFailure('An unexpected error occurred.'));
    }
  }
}
