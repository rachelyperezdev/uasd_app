import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/debt/domain/get_debts_usecase.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debt_event.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debt_state.dart';

class DebtsBloc extends Bloc<DebtEvent, DebtState> {
  final GetDebtsUsecase getDebtsUsecase;

  DebtsBloc({required this.getDebtsUsecase}) : super(DebtsInitial()) {
    on<FetchUnpaidDebtEvent>(_onFetchUnPaidDebts);
    on<FetchPaidDebtEvent>(_onFetchPaidDebts);
  }

  Future<void> _onFetchUnPaidDebts(
      FetchUnpaidDebtEvent event, Emitter<DebtState> emit) async {
    emit(DebtsLoading());

    final result = await getDebtsUsecase.callUnpaidDebts();

    result.fold(
        (failure) => emit(UnpaidDebtsError(
            message: "No se pudieron cargar las deudas pendientes.")),
        (unpaidDebts) => emit(UnpaidDebtsLoaded(unpaidDebts: unpaidDebts)));
  }

  Future<void> _onFetchPaidDebts(
      FetchPaidDebtEvent event, Emitter<DebtState> emit) async {
    emit(DebtsLoading()); // cargando

    final result =
        await getDebtsUsecase.callPaidDebts(); // llama al caso de uso

    // emite
    result.fold(
        (failure) => emit(PaidDebtsError(
            message: "No se pudieron cargar las deudas pagadas.")),
        (paidDebts) {
      if (paidDebts.isEmpty) {
        return emit(NoPaidDebts());
      } else {
        return emit(PaidDebtsLoaded(paidDebts: paidDebts));
      }
    });
  }
}