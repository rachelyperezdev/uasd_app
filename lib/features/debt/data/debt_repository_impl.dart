import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/debt_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/debt/domain/repositories/debt_repository.dart';

class DebtRepositoryImpl extends DebtRepository {
  final ApiClient apiClient;
  final int registeredUserId;

  DebtRepositoryImpl({required this.apiClient, required this.registeredUserId});

  // Busca todas las deudas
  Future<Either<Failure, List<DebtModel>>> _fetchDebts(
      {required bool paid}) async {
    try {
      final response = await apiClient.get('/deudas');

      if (response.isEmpty) {
        return Left(CustomFailure('Debts not found.'));
      }

      final List<dynamic> data = response as List<dynamic>;

      final List<DebtModel> allDebts =
          data.map((debt) => DebtModel.fromJson(debt)).toList();

      final List<DebtModel> userDebts = allDebts
          .where((debt) => debt.userId == registeredUserId && debt.paid == paid)
          .toList();

      return Right(userDebts);
    } catch (error) {
      return _handleError(error);
    }
  }

  // Muestra todas las deudas pendientes
  @override
  Future<Either<Failure, List<DebtModel>>> fetchDebts() async {
    return _fetchDebts(paid: false);
  }

  // Muestra las deudas pagas
  @override
  Future<Either<Failure, List<DebtModel>>> fetchPaidDebts() async {
    return _fetchDebts(paid: true);
  }

  Either<Failure, List<DebtModel>> _handleError(dynamic error) {
    if (error is NetworkException) {
      return Left(
          NetworkFailure('Network issue, please check your connection.'));
    } else if (error is ServerException) {
      return Left(ServerFailure('Failed to fetch assignments, try again.'));
    } else {
      return Left(CustomFailure('An unexpected error occurred.'));
    }
  }
}
