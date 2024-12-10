import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/features/landing/presentation/widgets/header_image_widget.dart';
import 'package:uasd_app/features/landing/presentation/widgets/info_section_widget.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildLoginAppBar(context: context),
          body: _buildBody(screenHeight: screenHeight),
        ));
  }

  // App Bar específicamente destinada para el landing
  AppBar _buildLoginAppBar({required BuildContext context}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: _buildLoginBtn(context: context),
        )
      ],
    );
  }

  // Botón para dirigir a la pantalla de inicio de sesión
  ElevatedButton _buildLoginBtn({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, AppConstants.loginRoute);
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          backgroundColor: AppConstants.primaryColor),
      child: Text(
        'Iniciar Sesión',
        style: TextStyle(color: AppConstants.tertiaryTxtColor),
      ),
    );
  }

  // Construye el cuerpo
  SingleChildScrollView _buildBody({required double screenHeight}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderImageWidget(height: screenHeight * 0.4),
          InfoSectionWidget(),
        ],
      ),
    );
  }
}
