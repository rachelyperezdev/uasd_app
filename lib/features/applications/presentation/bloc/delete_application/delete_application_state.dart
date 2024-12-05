import 'package:equatable/equatable.dart';

abstract class DeleteApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteApplicationInitial extends DeleteApplicationState {}

class DeleteApplicationLoading extends DeleteApplicationState {}

class DeleteApplicationSuccess extends DeleteApplicationState {
  final String message;
  final int applicationId;

  DeleteApplicationSuccess(
      {required this.message, required this.applicationId});

  @override
  List<Object?> get props => [message, applicationId];
}

class DeleteApplicationError extends DeleteApplicationState {
  final String message;

  DeleteApplicationError({required this.message});

  @override
  List<Object?> get props => [message];
}
