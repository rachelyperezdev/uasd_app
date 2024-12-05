import 'package:equatable/equatable.dart';
abstract class DebtEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class FetchUnpaidDebtEvent extends DebtEvent {}
class FetchPaidDebtEvent extends DebtEvent {}