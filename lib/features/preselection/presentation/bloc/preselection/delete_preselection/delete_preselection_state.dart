import 'package:equatable/equatable.dart';

abstract class DeletePreselectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeletePreselectionInitial extends DeletePreselectionState {}

class DeletePreselectionLoading extends DeletePreselectionState {}

class DeletePreselectionSuccess extends DeletePreselectionState {
  final String message;
  final String courseCode;

  DeletePreselectionSuccess({required this.message, required this.courseCode});

  @override
  List<Object?> get props => [message, courseCode];
}

class DeletePreselectionError extends DeletePreselectionState {
  final String message;

  DeletePreselectionError({required this.message});

  @override
  List<Object?> get props => [message];
}
