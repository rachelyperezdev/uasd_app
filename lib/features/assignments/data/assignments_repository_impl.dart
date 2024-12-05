import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/assignment_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/assignments/domain/repositories/assignments_repository.dart';

class AssignmentsRepositoryImpl extends AssignmentsRepository {
  final ApiClient apiClient;
  final int registeredUserId;

  AssignmentsRepositoryImpl(
      {required this.apiClient, required this.registeredUserId});

  // Busca las asignaturas
  Future<Either<Failure, List<AssignmentModel>>> _fetchAssignemnts(
      {bool? filteredCompleted}) async {
    try {
      final response = await apiClient.get('/tareas');

      final List<dynamic> data = response as List<dynamic>;

      final List<AssignmentModel> allAssignments = data
          .map((assignment) => AssignmentModel.fromJson(assignment))
          .toList();

      final List<AssignmentModel> userAssignments =
          _filterUserAssignments(allAssignments);

      if (filteredCompleted != null) {
        return Right(
            _filterAssignmentsByCompletion(userAssignments, filteredCompleted));
      }

      return Right(userAssignments);
    } catch (error) {
      return _handleError(error);
    }
  }

  // Retorna el fetching de las tareas
  @override
  Future<Either<Failure, List<AssignmentModel>>> fetchAssignemnts() async {
    return _fetchAssignemnts();
  }

  // Filtra las tareas completadas
  @override
  Future<Either<Failure, List<AssignmentModel>>>
      fetchCompletedAssignments() async {
    return _fetchAssignemnts(filteredCompleted: true);
  }

  // Filtra las tareas pendientes
  @override
  Future<Either<Failure, List<AssignmentModel>>>
      fetchPendingAssignments() async {
    return _fetchAssignemnts(filteredCompleted: false);
  }

  // Filtra las asignaturas por el ID del usuario,
  // ya que la API trae todas las tareas de todos los usuarios
  List<AssignmentModel> _filterUserAssignments(
      List<AssignmentModel> assignments) {
    return assignments
        .where((assignment) => assignment.userId == registeredUserId)
        .toList();
  }

  // Filtra las asignaturas dependiendo de su estado por el ID del usuario,
  // ya que la API trae todas las tareas de todos los usuarios
  List<AssignmentModel> _filterAssignmentsByCompletion(
      List<AssignmentModel> assignments, bool isCompleted) {
    return assignments
        .where((assignment) => assignment.completed == isCompleted)
        .toList();
  }

  Either<Failure, List<AssignmentModel>> _handleError(dynamic error) {
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