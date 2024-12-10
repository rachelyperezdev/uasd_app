import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

class DeveloperCard extends StatelessWidget {
  final String name;
  final String tuition;
  final String img;

  DeveloperCard({
    required this.name,
    required this.tuition,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: img.isEmpty
              ? Container(
                  width: double.infinity,
                  height: size.height,
                  color: const Color.fromARGB(255, 0, 37, 80),
                  child: Icon(
                    Icons.broken_image,
                    color: AppConstants.primaryColor,
                    size: 50,
                  ),
                )
              : Image.asset(
                  img,
                  width: double.infinity,
                  height: size.height,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          bottom: 2.0,
          left: 2.0,
          right: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppConstants.tertiaryTxtColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tuition,
                  style: TextStyle(
                      color: AppConstants.tertiaryTxtColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
