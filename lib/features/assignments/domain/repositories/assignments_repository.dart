import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/assignment_model.dart';

abstract class AssignmentsRepository {
  Future<Either<Failure, List<AssignmentModel>>> fetchAssignemnts();
  Future<Either<Failure, List<AssignmentModel>>> fetchCompletedAssignments();
  Future<Either<Failure, List<AssignmentModel>>> fetchPendingAssignments();
}