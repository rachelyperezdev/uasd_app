import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/debt_model.dart';

abstract class DebtRepository {
  Future<Either<Failure, List<DebtModel>>> fetchDebts();
  Future<Either<Failure, List<DebtModel>>> fetchPaidDebts();
}