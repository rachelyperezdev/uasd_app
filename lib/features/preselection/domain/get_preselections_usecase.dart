import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/preselection_model.dart';
import 'package:uasd_app/features/preselection/domain/repositories/preselection_repository.dart';

class GetPreselectionsUsecase {
  final PreselectionRepository preselectionRepository;

  GetPreselectionsUsecase({required this.preselectionRepository});

  Future<Either<Failure, List<PreselectionModel>>> callPreselection() async {
    return await preselectionRepository.fetchMyPreselection();
  }

  Future<Either<Failure, List<PreselectionModel>>>
      callConfirmedPreselection() async {
    return await preselectionRepository.fetchConfirmedPreselection();
  }

  Future<Either<Failure, List<PreselectionModel>>>
      callUnconfirmedPreselection() async {
    return await preselectionRepository.fetchUnconfirmedPreselection();
  }

  Future<Either<Failure, void>> deletePreselection(
      {required String courseCode}) async {
    return await preselectionRepository.deletePreselection(courseCode);
  }

  Future<Either<Failure, void>> addPreselection(
      CreatePreselectionModel preselection) async {
    return await preselectionRepository.createPreselection(preselection);
  }
}
