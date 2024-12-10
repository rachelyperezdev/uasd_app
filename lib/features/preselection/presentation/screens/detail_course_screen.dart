import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_card.dart';
import 'package:uasd_app/core/widgets/map_widget.dart';
import 'package:uasd_app/data/models/course_model.dart';

class DetailCourseScreen extends StatefulWidget {
  final CourseModel course;

  DetailCourseScreen({super.key, required this.course});

  @override
  DetailCourseState createState() => DetailCourseState();
}

class DetailCourseState extends State<DetailCourseScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildMap(screenHeight),
          _buildEventInfoContainer(screenHeight),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
          color: AppConstants.primaryColor, size: 30.0, weight: 100),
    );
  }

  // Mapa con la ubicación de la materia
  Widget _buildMap(double screenHeight) {
    return Container(
      height: screenHeight,
      child: MapWidget(coordinates: widget.course.location),
    );
  }

  // Contenedor de info
  Widget _buildEventInfoContainer(double screenHeight) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants.primaryBgColor,
              AppConstants.tertiaryTxtColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCourseTitle(),
              SizedBox(height: 12),
              buildTag(
                  message: widget.course.code,
                  color: const Color.fromARGB(255, 248, 251, 255)),
              SizedBox(height: 12),
              _buildCourseLocation(),
              SizedBox(height: 12),
              _buildCourseSchedule(),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // Nombre de la materia
  Widget _buildCourseTitle() {
    return Text(
      widget.course.name,
      style: TextStyle(
        color: AppConstants.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Ubicación
  Widget _buildCourseLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_pin,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Text(
          widget.course.classroom,
          style: TextStyle(
            color: AppConstants.bottomGradientColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  // Horario
  Widget _buildCourseSchedule() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Text(
          widget.course.schedule,
          style: TextStyle(
            color: AppConstants.bottomGradientColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

