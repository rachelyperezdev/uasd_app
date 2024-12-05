import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.tertiaryTxtColor,
      appBar: buildLightAppBar(title: 'Inicio'),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Expanded(child: _buildAllFunctionalities()),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Muestra todas las funcionalidades de la app
  Widget _buildAllFunctionalities() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: (50 / 20),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: AppConstants.mainFunctionalities.length,
      itemBuilder: (context, index) {
        final entry = AppConstants.mainFunctionalities.entries.elementAt(index);
        final name = entry.key;
        final icon = entry.value['icon'] as IconData;
        final route = entry.value['route'] as String;

        return _buildFunctionalityItem(
          name: name,
          icon: icon,
          route: route,
          context: context,
        );
      },
    );
  }

  // Muestra un item
  Widget _buildFunctionalityItem({
    required String name,
    required IconData icon,
    required String route,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppConstants.primaryColor, size: 60),
          SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppConstants.primaryColor),
          ),
        ],
      ),
    );
  }
}
