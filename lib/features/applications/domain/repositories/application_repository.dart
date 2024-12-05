import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/application_model.dart';

abstract class ApplicationRepository {
  Future<Either<Failure, List<ApplicationTypeModel>>> fetchApplicationTypes();
  Future<Either<Failure, List<ApplicationModel>>> fetchApplications();
  Future<Either<Failure, void>> createApplication(
      CreateApplicationModel application);
  Future<Either<Failure, void>> deleteApplication(int applicationId);
}