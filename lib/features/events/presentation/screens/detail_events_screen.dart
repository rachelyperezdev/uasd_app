import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/map_widget.dart';
import 'package:uasd_app/data/models/event_model.dart';

class DetailEventsScreen extends StatefulWidget {
  final EventModel event;

  DetailEventsScreen({super.key, required this.event});

  @override
  DetailEventsState createState() => DetailEventsState();
}

class DetailEventsState extends State<DetailEventsScreen> {
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
          color: AppConstants.primaryTxtColor, size: 30.0, weight: 100),
    );
  }

  Widget _buildMap(double screenHeight) {
    return Container(
      height: screenHeight,
      child: MapWidget(coordinates: widget.event.coordinates),
    );
  }

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
              _buildEventTitle(),
              SizedBox(height: 12),
              _buildEventLocation(),
              SizedBox(height: 12),
              _buildEventDate(),
              SizedBox(height: 12),
              _buildEventDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventTitle() {
    return Text(
      widget.event.title,
      style: TextStyle(
        color: AppConstants.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEventLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_pin,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.event.location,
            style: TextStyle(
              color: AppConstants.bottomGradientColor,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEventDate() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            DateFormat('dd/MM/yy, HH:mm').format(widget.event.eventDate),
            style: TextStyle(
              color: AppConstants.bottomGradientColor,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEventDescription() {
    return Text(
      widget.event.description,
      style: TextStyle(
        color: AppConstants.bottomGradientColor,
        fontSize: 16,
      ),
    );
  }
}
