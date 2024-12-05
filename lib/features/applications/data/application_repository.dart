import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/application_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/applications/domain/repositories/application_repository.dart';

class ApplicationRepositoryImpl extends ApplicationRepository {
  final ApiClient apiClient;

  ApplicationRepositoryImpl({
    required this.apiClient,
  });

  // Agregar solicitud
  @override
  Future<Either<Failure, void>> createApplication(
      CreateApplicationModel application) async {
    try {
      final response =
          await apiClient.post('/crear_solicitud', data: application.toJson());

      if (response["success"]) {
        return Right(null);
      } else {
        return Left(CustomFailure('Failed to create the application'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Cancelar solicitud
  @override
  Future<Either<Failure, void>> deleteApplication(int applicationId) async {
    try {
      final response = await apiClient.post(
        '/cancelar_solicitud',
        data: applicationId.toString(),
      );

      if (response != null) {
        return Right(null);
      } else {
        return Left(ServerFailure('Failed to delete application'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Mostras las solicitudes
  @override
  Future<Either<Failure, List<ApplicationModel>>> fetchApplications() async {
    try {
      final response = await apiClient.get('/mis_solicitudes');

      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];

        final List<ApplicationModel> applications = data
            .map((application) => ApplicationModel.fromJson(application))
            .toList();

        return Right(applications);
      } else {
        return Left(ServerFailure('Invalid response from server.'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Muestra los tipos de solicitudes
  @override
  Future<Either<Failure, List<ApplicationTypeModel>>>
      fetchApplicationTypes() async {
    try {
      final response = await apiClient.get('/tipos_solicitudes');

      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];

        final List<ApplicationTypeModel> applicationTypes = data
            .map((applicationType) =>
                ApplicationTypeModel.fromJson(applicationType))
            .toList();

        return Right(applicationTypes);
      } else {
        return Left(ServerFailure('Invalid response from server.'));
      }
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
