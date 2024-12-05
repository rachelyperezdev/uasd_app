import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';

class HeaderImageWidget extends StatelessWidget {
  final double height;

  const HeaderImageWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://uasd.edu.do/wp-content/uploads/UASD-13.jpg',
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
              AppConstants.universityName,
              style: TextStyle(
                color: AppConstants.tertiaryTxtColor,
                fontWeight: FontWeight.bold,
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