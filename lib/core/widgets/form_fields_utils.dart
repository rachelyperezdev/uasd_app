// Campos de Formularios

// Campo de texto
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

Widget buildTxtFormField({
  required TextEditingController controller,
  required String labelText,
  required String errorMessage,
  bool isTextObscured = false,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    cursorColor: AppConstants.tertiaryTxtColor,
    cursorErrorColor: AppConstants.tertiaryTxtColor,
    obscureText: isTextObscured,
    maxLines: maxLines,
    style: TextStyle(color: AppConstants.tertiaryTxtColor),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: AppConstants.tertiaryTxtColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      errorStyle: TextStyle(
        color: AppConstants.tertiaryTxtColor,
        fontSize: 14,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    },
  );
}

// Campo para comparar valores y determinar coincidencia
Widget buildConfirmCoincidenceTxtFormField({
  required TextEditingController controller,
  required String confirmation,
  required String labelText,
  required String errorMessage,
  required String confirmationError,
  bool isTextObscured = false,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    cursorColor: AppConstants.tertiaryTxtColor,
    cursorErrorColor: AppConstants.tertiaryTxtColor,
    obscureText: isTextObscured,
    maxLines: maxLines,
    style: TextStyle(color: AppConstants.tertiaryTxtColor),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: AppConstants.tertiaryTxtColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      errorStyle: TextStyle(
        color: AppConstants.tertiaryTxtColor,
        fontSize: 14,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }

      if (value != confirmation) {
        return confirmationError;
      }
      return null;
    },
  );
}
