// Indicador circular para indicar 'cargando'
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

Widget buildLoading({Color color = AppConstants.primaryColor}) {
  return Center(
    child: CircularProgressIndicator(
      color: color,
    ),
  );
}
