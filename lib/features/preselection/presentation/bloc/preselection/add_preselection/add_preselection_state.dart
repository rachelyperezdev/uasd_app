import 'package:equatable/equatable.dart';

abstract class AddPreselectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddPreselectionInitial extends AddPreselectionState {}

class AddPreselectionLoading extends AddPreselectionState {}

class NoAddedPreselection extends AddPreselectionState {}

class AddPreselectionLoaded extends AddPreselectionState {}

class AddPreselectionError extends AddPreselectionState {
  final String message;

  AddPreselectionError({required this.message});

  @override
  List<Object?> get props => [message];
}
