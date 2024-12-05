import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/application_model.dart';

abstract class ApplicationTypesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApplicationTypesInitial extends ApplicationTypesState {}

class ApplicationTypesLoading extends ApplicationTypesState {}

class NoApplicationTypes extends ApplicationTypesState {}

class ApplicationTypesLoaded extends ApplicationTypesState {
  final List<ApplicationTypeModel> applicationTypes;

  ApplicationTypesLoaded({required this.applicationTypes});

  @override
  List<Object?> get props => [applicationTypes];
}

class ApplicationTypesError extends ApplicationTypesState {
  final String message;

  ApplicationTypesError({required this.message});

  @override
  List<Object?> get props => [message];
}
