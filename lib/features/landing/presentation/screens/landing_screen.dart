import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          body: Center(),
        ));
  }
}
