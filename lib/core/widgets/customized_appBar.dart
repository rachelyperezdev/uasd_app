// App bar transparente
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

AppBar buildTransparentAppBar({Color? iconColor}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(
        color: iconColor ?? AppConstants.tertiaryTxtColor, size: 30.0),
  );
}

// App bar clara
AppBar buildLightAppBar({required String title}) {
  return AppBar(
      backgroundColor: const Color.fromARGB(255, 240, 247, 255),
      title: Text(
        title,
        style: TextStyle(
            color: AppConstants.primaryColor, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: AppConstants.primaryColor, size: 30.0));
}

// App bar oscura
AppBar buildDarkAppBar({required String title}) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 39, 118, 255),
    elevation: 0,
    iconTheme: IconThemeData(color: AppConstants.tertiaryTxtColor),
    title: Text(
      title,
      style: TextStyle(color: AppConstants.tertiaryTxtColor),
    ),
  );
}
