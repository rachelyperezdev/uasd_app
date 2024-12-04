// ELEMENTOS DE UN CARD

// Decoración
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

BoxDecoration buildCardDecoration([Color? statusColor]) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    gradient: LinearGradient(
      colors: [Colors.white, Colors.grey.shade200],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: AppConstants.primaryColor.withOpacity(0.08),
        spreadRadius: 2,
        blurRadius: 12,
        offset: Offset(3, 3),
      ),
    ],
    border: statusColor != null
        ? Border(
            left: BorderSide(color: statusColor, width: 3.0),
          )
        : null,
  );
}

// Subtítulo
Widget buildSubtitle({required String title, String? content}) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
            color: AppConstants.primaryColor, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 2),
      if (content != null || content!.isNotEmpty)
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              color: AppConstants.primaryColor,
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
    ],
  );
}

// Descripción
Widget buildDescription({required String description}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 255, 255, 255),
                const Color.fromARGB(255, 247, 247, 247)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(
              color: AppConstants.primaryColor,
              width: 0.09,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
            style: TextStyle(color: AppConstants.primaryColor, fontSize: 16),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}

// Etiqueta
Widget buildTag({required String message, Color? color}) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Container(
          constraints: BoxConstraints(maxWidth: 200),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: color ?? AppConstants.tertiaryTxtColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: AppConstants.primaryColor,
            ),
          ),
        ),
      ),
    ],
  );
}
