import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/debt_model.dart';

abstract class DebtState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DebtsInitial extends DebtState {}

class DebtsLoading extends DebtState {}

class PaidDebtsLoaded extends DebtState {
  final List<DebtModel> paidDebts;

  PaidDebtsLoaded({required this.paidDebts});

  @override
  List<Object?> get props => [paidDebts];
}

class UnpaidDebtsLoaded extends DebtState {
  final List<DebtModel> unpaidDebts;

  UnpaidDebtsLoaded({required this.unpaidDebts});

  @override
  List<Object?> get props => [unpaidDebts];
}

class PaidDebtsError extends DebtState {
  final String message;

  PaidDebtsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnpaidDebtsError extends DebtState {
  final String message;

  UnpaidDebtsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NoPaidDebts extends DebtState {}

class NoUnpaidDebts extends DebtState {}
