import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/features/about_developers/presentation/widgets/developer_card_widget.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

// Pantalla de 'Sobre los Desarrolladores'
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
      appBar: buildDarkAppBar(title: ""),
      drawer: HomeDrawer(),
      body: SafeArea(
        child: Container(
          decoration: _buildGradientBackground(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeaderText(),
                _buildDeveloperCards(titles, images),
                _buildDescriptionContainer(
                    description:
                        '<Alexander Hilario/>\nEs un desarrollador con interés en lenguajes como Python, en especial, en el desarrollo de scripts automatizados.'),
                _buildDescriptionContainer(
                    description:
                        '<Héctor Medina/>\nEs un desarrollador web con interés en las tecnologías de JavaScript, enfocado en crear aplicaciones intuitivas, accesibles y fáciles de usar para mejorar la experiencia del usuario.'),
                _buildDescriptionContainer(
                    description:
                        '<Rachely Pérez/>\nEs una desarrolladora interesada en ASP.NET, React y Flutter, con habilidades en el desarrollo de aplicaciones modernas, tanto web como móviles, centradas en la experiencia del usuario y el código limpio.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fondo con gradiente
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

  // Encabezado
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

  // Card Pager con información de los desarrolladores
  Widget _buildDeveloperCards(List<String> titles, List<Widget> images) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: VerticalCardPager(
        initialPage: 1,
        titles: titles,
        images: images,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  // Contenedor de descripción
  Widget _buildDescriptionContainer({required String description}) {
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
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 215, 233, 253),
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

