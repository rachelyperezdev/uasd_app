import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/event_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/events/domain/repositories/events_repository.dart';

class EventsRepositoryImpl extends EventsRepository {
  final ApiClient apiClient;

  EventsRepositoryImpl({required this.apiClient});

  // Busca los eventos
  @override
  Future<Either<Failure, List<EventModel>>> fetchEvents() async {
    try {
      final response = await apiClient.get('/eventos');

      if (response.isEmpty) {
        return Left(CustomFailure('No events found.'));
      }

      final List<dynamic> data = response as List<dynamic>;

      final List<EventModel> events =
          data.map((json) => EventModel.fromJson(json)).toList();

      return Right(events);
    } catch (error) {
      return _handleError(error);
    }
  }

  Either<Failure, List<EventModel>> _handleError(dynamic error) {
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