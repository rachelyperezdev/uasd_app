import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/map_widget.dart';
import 'package:uasd_app/data/models/schedule_model.dart';

// Muestra el detalle del Horario
class DetailScheduleScreen extends StatefulWidget {
  final ScheduleModel schedule;

  DetailScheduleScreen({super.key, required this.schedule});

  @override
  DetailScheduleState createState() => DetailScheduleState();
}

class DetailScheduleState extends State<DetailScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: buildTransparentAppBar(),
      body: Stack(
        children: [
          _buildMap(screenHeight),
          _buildScheduleInfoContainer(screenHeight),
        ],
      ),
    );
  }

  // muestra el mapa
  Widget _buildMap(double screenHeight) {
    return Container(
      height: screenHeight,
      child: MapWidget(coordinates: widget.schedule.location),
    );
  }

  // contenedor de la info del horario
  Widget _buildScheduleInfoContainer(double screenHeight) {
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
          color: AppConstants.primaryBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildScheduleTitle(),
              SizedBox(height: 12),
              _buildScheduleLocation(),
              SizedBox(height: 12),
              _buildScheduleDate(),
            ],
          ),
        ),
      ),
    );
  }

  // título del horario
  Widget _buildScheduleTitle() {
    return Text(
      widget.schedule.course,
      style: TextStyle(
        color: AppConstants.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // lugar
  Widget _buildScheduleLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_pin,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.schedule.classroom,
            style: TextStyle(
              color: AppConstants.bottomGradientColor,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  // fecha y hora
  Widget _buildScheduleDate() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            DateFormat('dd/MM/yy, HH:mm').format(widget.schedule.dateHour),
            style: TextStyle(
              color: AppConstants.bottomGradientColor,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}