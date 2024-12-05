import 'package:equatable/equatable.dart';

abstract class AddApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddApplicationInitial extends AddApplicationState {}

class AddApplicationLoading extends AddApplicationState {}

class NoAddedApplication extends AddApplicationState {}

class AddApplicationLoaded extends AddApplicationState {}

class AddApplicationError extends AddApplicationState {
  final String message;

  AddApplicationError({required this.message});

  @override
  List<Object?> get props => [message];
}
