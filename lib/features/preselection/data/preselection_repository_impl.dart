import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/course_model.dart';
import 'package:uasd_app/data/models/preselection_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/preselection/domain/repositories/preselection_repository.dart';

// Preselección
class PreselectionRepositoryImpl extends PreselectionRepository {
  final ApiClient apiClient;

  PreselectionRepositoryImpl({required this.apiClient});

  // Crea preselección
  @override
  Future<Either<Failure, void>> createPreselection(
      CreatePreselectionModel preselection) async {
    try {
      final response = await apiClient.post('/preseleccionar_materia',
          data: jsonEncode(preselection.courseCode));

      if (response["success"]) {
        return Right(null);
      } else if (response["error"] == "La materia ya está preseleccionada") {
        return Left(CustomFailure());
      } else {
        return Left(
            CustomFailure('Failed to add the course into the preselection'));
      }
    } catch (error) {
      print("Error $error");
      return _handleError(error);
    }
  }

  @override
  Future<Either<Failure, List<PreselectionModel>>> fetchMyPreselection() async {
    return await _fetchPreselection();
  }

  // Busca las preselecciones confirmadas
  @override
  Future<Either<Failure, List<PreselectionModel>>>
      fetchConfirmedPreselection() async {
    return await _fetchPreselection(confirmed: true);
  }

  // Busca las preselecciones sin confirmar
  @override
  Future<Either<Failure, List<PreselectionModel>>>
      fetchUnconfirmedPreselection() async {
    return await _fetchPreselection(confirmed: false);
  }

  // Busca la preselección
  Future<Either<Failure, List<PreselectionModel>>> _fetchPreselection(
      {bool? confirmed}) async {
    try {
      final responsePreselection = await apiClient.get('/ver_preseleccion');
      final responseCourses = await apiClient.get('/materias_disponibles');

      if (responsePreselection is Map<String, dynamic>) {
        final dataPreselection = responsePreselection['data'] as List<dynamic>?;

        if (dataPreselection != null) {
          if (responseCourses is List<dynamic>) {
            final List<dynamic> dataCourses = responseCourses;
            final List<CourseModel> courses = dataCourses
                .map((course) => CourseModel.fromJson(course))
                .toList();

            final List<PreselectionModel> preselection =
                dataPreselection.map((preselection) {
              final preselectionModel =
                  PreselectionModel.fromJson(preselection);

              final course = courses.firstWhere(
                  (course) => course.name == preselectionModel.course,
                  orElse: () => CourseModel(
                      code: '',
                      name: '',
                      schedule: '',
                      classroom: '',
                      location: ''));

              return PreselectionModel(
                  course: preselectionModel.course,
                  confirmed: preselectionModel.confirmed,
                  selectionDate: preselectionModel.selectionDate,
                  courseCode: course.code,
                  classroom: preselectionModel.classroom,
                  location: preselectionModel.location);
            }).toList();

            if (confirmed != null) {
              return Right(
                  _filterPreselectionByConfirmation(preselection, confirmed));
            }

            return Right(preselection);
          } else {
            return Left(
                CustomFailure('La respuesta de cursos no es una lista.'));
          }
        } else {
          return Left(CustomFailure(
              'La respuesta de preselección no contiene la lista esperada.'));
        }
      } else {
        return Left(
            CustomFailure('La respuesta de preselección no es un mapa.'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Elimina una preselección
  @override
  Future<Either<Failure, void>> deletePreselection(String courseCode) async {
    try {
      final response = await apiClient.post(
        '/cancelar_preseleccion_materia',
        data: jsonEncode(courseCode),
      );

      if (response != null) {
        return Right(null);
      } else {
        return Left(ServerFailure('Failed cancelling the preselection'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Filtro de las preselecciones de acuerdo a la confirmación
  List<PreselectionModel> _filterPreselectionByConfirmation(
      List<PreselectionModel> preselection, bool isConfirmed) {
    return preselection
        .where((preselection) => preselection.confirmed == isConfirmed)
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
