// Imagen como Header
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

class HeaderImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final String title;
  final double fontSize;

  const HeaderImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.title,
    this.fontSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: height,
              color: AppConstants.primaryColor,
              child: Icon(
                Icons.broken_image,
                color: AppConstants.secondaryColor,
                size: 50,
              ),
            );
          },
        ),
        Positioned(
          bottom: 16.0,
          left: 8.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppConstants.tertiaryTxtColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
