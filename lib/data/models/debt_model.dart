import 'package:decimal/decimal.dart';

// Modelo de Deuda
class DebtModel {
  final int id;
  final int userId;
  final Decimal amount;
  final bool paid;
  final DateTime updatedDate;

  DebtModel(
      {required this.id,
      required this.userId,
      required this.amount,
      required this.paid,
      required this.updatedDate});

  // Adapter de json a modelo
  factory DebtModel.fromJson(Map<String, dynamic> json) {
    return DebtModel(
        id: json['id'],
        userId: json['usuarioId'],
        amount: Decimal.parse(json['monto'].toString()),
        paid: json['pagada'],
        updatedDate: DateTime.parse(json['fechaActualizacion'] as String));
  }
}
