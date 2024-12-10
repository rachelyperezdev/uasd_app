import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

// Indicador circular para indicar 'cargando'
Widget buildLoading({Color color = AppConstants.primaryColor}) {
  return Center(
    child: CircularProgressIndicator(
      color: color,
    ),
  );
}
