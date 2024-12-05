import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/schedule_model.dart';

abstract class ScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ScheduleModel> schedules;

  ScheduleLoaded({required this.schedules});

  @override
  List<Object?> get props => [schedules];
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NoSchedules extends ScheduleState {}
