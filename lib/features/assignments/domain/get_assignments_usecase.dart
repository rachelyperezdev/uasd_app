import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/assignment_model.dart';
import 'package:uasd_app/features/assignments/domain/repositories/assignments_repository.dart';

class GetAssignmentsUsecase {
  final AssignmentsRepository assignmentsRepository;

  GetAssignmentsUsecase({required this.assignmentsRepository});

  Future<Either<Failure, List<AssignmentModel>>> callAssignments() async {
    return await assignmentsRepository.fetchAssignemnts();
  }

  Future<Either<Failure, List<AssignmentModel>>>
      callPendingAssignments() async {
    return await assignmentsRepository.fetchPendingAssignments();
  }

  Future<Either<Failure, List<AssignmentModel>>>
      callCompletedAssignments() async {
    return await assignmentsRepository.fetchCompletedAssignments();
  }
}