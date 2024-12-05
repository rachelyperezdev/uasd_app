// Pantalla de 'Sobre los Desarrolladores'
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/features/about_developers/presentation/widgets/developer_card_widget.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
class AboutDevelopersScreen extends StatefulWidget {
  AboutDevelopersScreen({super.key});

  @override
  AboutDevelopersState createState() => AboutDevelopersState();
}

class AboutDevelopersState extends State<AboutDevelopersScreen> {
  @override
  Widget build(BuildContext context) {
    final titles = AppConstants.developers.map((dev) => "").toList();
    final images = AppConstants.developers.map((dev) {
      return DeveloperCard(
        name: dev["name"] ?? "",
        tuition: dev["tuition"] ?? "",
        img: dev["img"] ?? "",
      );
    }).toList();

    return Scaffold(
      appBar: _buildAppBar(title: ""),
      drawer: HomeDrawer(),
      body: SafeArea(
        child: Container(
          decoration: _buildGradientBackground(),
          child: Column(
            children: [
              _buildHeaderText(),
              _buildDeveloperCards(titles, images),
              _buildDescriptionContainer(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 39, 118, 255),
      elevation: 0,
      iconTheme: IconThemeData(color: AppConstants.tertiaryTxtColor),
      title: Text(
        title,
        style: TextStyle(color: AppConstants.primaryColor),
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 39, 118, 255),
          Color.fromARGB(255, 23, 73, 159)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _buildHeaderText() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Conoce a los desarrolladores".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConstants.tertiaryTxtColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCards(List<String> titles, List<Widget> images) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: VerticalCardPager(
          initialPage: 1,
          titles: titles,
          images: images,
          physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }

  Widget _buildDescriptionContainer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Este es el equipo de desarrolladores encargados de crear esta aplicación para los estudiantes de la Universidad Autónoma de Santo Domingo.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.tertiaryTxtColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
