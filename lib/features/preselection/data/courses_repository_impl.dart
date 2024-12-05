import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/course_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/preselection/domain/repositories/courses_repository.dart';

// Materias
class CoursesRepositoryImpl extends CoursesRepository {
  final ApiClient apiClient;

  CoursesRepositoryImpl({required this.apiClient});

  // Busca todas la materias
  @override
  Future<Either<Failure, List<CourseModel>>> fetchCourses() async {
    try {
      final response = await apiClient.get('/materias_disponibles');

      if (response.isEmpty) {
        return Left(CustomFailure('No courses found.'));
      }

      final List<dynamic> data = response as List<dynamic>;

      final List<CourseModel> courses =
          data.map((course) => CourseModel.fromJson(course)).toList();

      return Right(courses);
    } catch (error) {
      return _handleError(error);
    }
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