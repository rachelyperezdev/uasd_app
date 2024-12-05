import 'package:equatable/equatable.dart';

abstract class PreselectionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPreselection extends PreselectionEvent {}

class FetchConfirmedPreselection extends PreselectionEvent {}

class FetchUnconfirmedPreselection extends PreselectionEvent {}
