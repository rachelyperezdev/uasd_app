import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

// Elevated Buttons Personalizados

// Simple
Widget buildElevatedButton(
    {required VoidCallback onPressed,
    required String text,
    Color? backgroundColor = AppConstants.tertiaryTxtColor,
    Color? txtColor = AppConstants.primaryColor}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      minimumSize: Size(double.infinity, 50),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: txtColor,
        fontSize: 16,
      ),
    ),
  );
}

// De redirección
Widget buildRedirectionBtn(
    {required VoidCallback onPressed, required String text, String? url}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 2, 117, 249),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppConstants.tertiaryTxtColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ));
}