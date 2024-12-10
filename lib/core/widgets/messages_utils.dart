import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

// Snackbar personalizable
SnackBar buildCustomizedSnackBar(
    {required String message, IconData icon = Icons.info, Color? bgColor}) {
  return SnackBar(
    backgroundColor: bgColor ?? AppConstants.tertiaryTxtColor,
    content: Row(
      children: [
        Icon(
          icon,
          color: AppConstants.primaryTxtColor,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: AppConstants.primaryTxtColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

// Contenedor de mensajes
Widget buildMessageContainer({
  required String message,
  IconData? icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 24),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
            top: BorderSide(color: AppConstants.primaryColor, width: 0.2),
            bottom: BorderSide(color: AppConstants.primaryColor, width: 0.2),
            right: BorderSide(color: AppConstants.primaryColor, width: 0.2),
            left: BorderSide(color: AppConstants.primaryColor, width: 0.2)),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 232, 243, 255),
            const Color.fromARGB(255, 225, 239, 255)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.08),
            spreadRadius: 4,
            blurRadius: 12,
            offset: Offset(3, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.info,
            color: AppConstants.primaryColor,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: AppConstants.primaryColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
  );
}
