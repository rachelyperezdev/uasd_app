import 'package:equatable/equatable.dart';

abstract class AssignmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAssignments extends AssignmentEvent {}

class FetchCompletedAssignments extends AssignmentEvent {}

class FetchPendingAssignments extends AssignmentEvent {}