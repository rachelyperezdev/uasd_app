import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/launch_url.dart';
import 'package:uasd_app/data/models/debt_model.dart';

class DebtContainer extends StatelessWidget {
  final List<DebtModel> debts;

  DebtContainer({required this.debts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: debts.map((debt) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _buildDebtCard(context, debt),
        );
      }).toList(),
    );
  }

  // Card de la deuda
  Widget _buildDebtCard(BuildContext context, DebtModel debt) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: _buildCardDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _buildDebtAmount(amount: debt.amount),
                  SizedBox(width: 10),
                  Expanded(child: Container()),
                  _buildPaymentBtn(
                    context: context,
                    url: AppConstants.paymentUrl,
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildDebtUpdatedDate(debt.updatedDate),
            ],
          ),
        ),
      ),
    );
  }

  // Apariencia
  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      gradient: LinearGradient(
        colors: [AppConstants.primaryColor, AppConstants.bottomGradientColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: [
        BoxShadow(
          color: AppConstants.primaryColor.withOpacity(0.08),
          spreadRadius: 10,
          blurRadius: 8,
          offset: Offset(3, 3),
        ),
      ],
    );
  }

  // Botón para pagar que redirige a la página de pago de la UASD
  Widget _buildPaymentBtn(
      {required BuildContext context, required String url}) {
    return ElevatedButton(
      onPressed: () => openUrl(context, url), // redirige a la página de la UASD
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.bottomGradientColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      child: Text(
        'Pagar',
        style: TextStyle(
          color: AppConstants.tertiaryTxtColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Cantidad de la deuda
  Widget _buildDebtAmount({required Decimal amount}) {
    return Row(
      children: [
        Icon(
          Icons.monetization_on_outlined,
          color: AppConstants.tertiaryTxtColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          amount.toString(),
          style: const TextStyle(
            color: AppConstants.tertiaryTxtColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Fecha de actualización de la deuda
  Widget _buildDebtUpdatedDate(DateTime eventDate) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: AppConstants.tertiaryTxtColor,
        ),
        SizedBox(width: 8),
        Text(
          "Última actualización: ${DateFormat('dd/MM/yyyy').format(eventDate)}",
          style: const TextStyle(
            color: AppConstants.tertiaryTxtColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}