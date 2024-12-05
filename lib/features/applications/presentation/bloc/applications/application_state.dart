import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/application_model.dart';

abstract class ApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApplicationInitial extends ApplicationState {}

class ApplicationLoading extends ApplicationState {}

class NoApplications extends ApplicationState {}

class ApplicationsLoaded extends ApplicationState {
  final List<ApplicationModel> applications;

  ApplicationsLoaded({required this.applications});

  @override
  List<Object?> get props => [applications];
}

class ApplicationsError extends ApplicationState {
  final String message;

  ApplicationsError({required this.message});

  @override
  List<Object?> get props => [message];
}
