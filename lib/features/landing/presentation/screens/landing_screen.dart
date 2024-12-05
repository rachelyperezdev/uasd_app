import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/features/landing/presentation/widgets/header_image_widget.dart';
import 'package:uasd_app/features/landing/presentation/widgets/info_section_widget.dart';


class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.loginRoute);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    backgroundColor: AppConstants.primaryColor),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: AppConstants.tertiaryTxtColor),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderImageWidget(height: screenHeight * 0.4),
              InfoSectionWidget(),
            ],
          ),
        ));
  }
}
