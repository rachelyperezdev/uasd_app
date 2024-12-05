import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/preselection_model.dart';

abstract class PreselectionRepository {
  Future<Either<Failure, List<PreselectionModel>>> fetchMyPreselection();
  Future<Either<Failure, List<PreselectionModel>>> fetchConfirmedPreselection();
  Future<Either<Failure, List<PreselectionModel>>>
      fetchUnconfirmedPreselection();
  Future<Either<Failure, void>> createPreselection(
      CreatePreselectionModel preselection);
  Future<Either<Failure, void>> deletePreselection(String courseCode);
}
