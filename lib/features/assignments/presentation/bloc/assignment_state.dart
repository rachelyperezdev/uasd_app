import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/assignment_model.dart';

abstract class AssignmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class NoAssignments extends AssignmentState {}

class NoCompletedAssignments extends AssignmentState {}

class NoPendingAssignments extends AssignmentState {}

class AssignmentsLoaded extends AssignmentState {
  final List<AssignmentModel> assignments;

  AssignmentsLoaded({required this.assignments});

  @override
  List<Object?> get props => [assignments];
}

class CompletedAssignmentsLoaded extends AssignmentState {
  final List<AssignmentModel> completedAssignments;

  CompletedAssignmentsLoaded({required this.completedAssignments});

  @override
  List<Object?> get props => [completedAssignments];
}

class PendingAssignmentsLoaded extends AssignmentState {
  final List<AssignmentModel> pendingAssignments;

  PendingAssignmentsLoaded({required this.pendingAssignments});

  @override
  List<Object?> get props => [pendingAssignments];
}

class AssignmentsError extends AssignmentState {
  final String message;

  AssignmentsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CompletedAssignmentsError extends AssignmentState {
  final String message;

  CompletedAssignmentsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PendingAssignmentsError extends AssignmentState {
  final String message;

  PendingAssignmentsError({required this.message});

  @override
  List<Object?> get props => [message];
}