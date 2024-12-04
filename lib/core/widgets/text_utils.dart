// Elementos de texto del Landing Page
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

Widget buildTitle(
    {required String title,
    Color color = AppConstants.primaryTxtColor,
    double fontSize = 16}) {
  return Text(
    title,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    textAlign: TextAlign.left,
  );
}

Widget buildUnderline(
    {required width,
    required height,
    Color? color = AppConstants.primaryColor}) {
  return Container(
    height: height,
    width: width,
    color: color,
  );
}

Widget buildContent(
    {required String content,
    double size = 16,
    Color color = AppConstants.primaryTxtColor}) {
  return Text(
    content,
    style: TextStyle(
      color: color,
      fontSize: size,
    ),
  );
}
