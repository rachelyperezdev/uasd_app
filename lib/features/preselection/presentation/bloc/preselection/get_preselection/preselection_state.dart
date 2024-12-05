import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/preselection_model.dart';

abstract class PreselectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreselectionInitial extends PreselectionState {}

class PreselectionLoading extends PreselectionState {}

class PreselectionLoaded extends PreselectionState {
  final List<PreselectionModel> preselection;

  PreselectionLoaded({required this.preselection});

  @override
  List<Object?> get props => [];
}

class ConfirmedPreselectionLoaded extends PreselectionState {
  final List<PreselectionModel> confirmedPreselection;

  ConfirmedPreselectionLoaded({required this.confirmedPreselection});

  @override
  List<Object?> get props => [confirmedPreselection];
}

class UnconfirmedPreselectionLoaded extends PreselectionState {
  final List<PreselectionModel> unconfirmedPreselection;

  UnconfirmedPreselectionLoaded({required this.unconfirmedPreselection});

  @override
  List<Object?> get props => [unconfirmedPreselection];
}

class NoPreselection extends PreselectionState {}

class NoConfirmedPreselection extends PreselectionState {}

class NoUnconfirmedPreselection extends PreselectionState {}

class PreselectionError extends PreselectionState {
  final String message;

  PreselectionError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ConfirmedPreselectionError extends PreselectionState {
  final String message;

  ConfirmedPreselectionError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnconfirmedPreselectionError extends PreselectionState {
  final String message;

  UnconfirmedPreselectionError({required this.message});

  @override
  List<Object?> get props => [message];
}
