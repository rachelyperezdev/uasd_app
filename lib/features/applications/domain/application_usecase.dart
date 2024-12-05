import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/application_model.dart';
import 'package:uasd_app/features/applications/domain/repositories/application_repository.dart';

class ApplicationUsecase {
  final ApplicationRepository applicationRepository;

  ApplicationUsecase({required this.applicationRepository});

  Future<Either<Failure, List<ApplicationTypeModel>>>
      getApplicationTypes() async {
    return await applicationRepository.fetchApplicationTypes();
  }

  Future<Either<Failure, List<ApplicationModel>>> getApplications() async {
    return await applicationRepository.fetchApplications();
  }

  Future<Either<Failure, void>> addApplication(
      CreateApplicationModel application) async {
    return await applicationRepository.createApplication(application);
  }

  Future<Either<Failure, void>> deleteApplication(
      {required int applicationId}) async {
    return await applicationRepository.deleteApplication(applicationId);
  }
}
