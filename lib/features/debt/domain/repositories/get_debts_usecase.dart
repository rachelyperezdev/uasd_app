import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/debt_model.dart';
import 'package:uasd_app/features/debt/domain/repositories/debt_repository.dart';

class GetDebtsUsecase {
  final DebtRepository debtRepository;

  GetDebtsUsecase({required this.debtRepository});

  Future<Either<Failure, List<DebtModel>>> callUnpaidDebts() async {
    return await debtRepository.fetchDebts();
  }

  Future<Either<Failure, List<DebtModel>>> callPaidDebts() async {
    return await debtRepository.fetchPaidDebts();
  }
}