// Contenedor con Gradiente
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

Widget buildGradientContainer({
  required String title1,
  required String title2,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 222, 238, 255),
          const Color.fromARGB(255, 186, 218, 255)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1.toUpperCase(),
                style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (title2.isNotEmpty)
                Text(
                  title2.toUpperCase(),
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
