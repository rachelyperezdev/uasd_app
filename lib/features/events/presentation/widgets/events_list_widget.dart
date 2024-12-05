import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/data/models/event_model.dart';
import 'package:uasd_app/features/events/presentation/screens/detail_events_screen.dart';

class EventsListWidget extends StatelessWidget {
  final List<EventModel> eventsList;

  const EventsListWidget({super.key, required this.eventsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: eventsList.length,
      itemBuilder: (context, index) {
        final event = eventsList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _buildEventItem(context, event),
        );
      },
    );
  }

  Widget _buildEventItem(BuildContext context, EventModel event) {
    return GestureDetector(
      onTap: () => _navigateToDetailScreen(context, event),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        shadowColor: AppConstants.primaryColor.withOpacity(0.01),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: _buildEventCardContent(event),
      ),
    );
  }

  void _navigateToDetailScreen(BuildContext context, EventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailEventsScreen(event: event),
      ),
    );
  }

  Widget _buildEventCardContent(EventModel event) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(3, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventTitle(event.title),
          SizedBox(height: 8),
          _buildEventLocation(event.location),
          SizedBox(height: 8),
          _buildEventDate(event.eventDate),
        ],
      ),
    );
  }

  Widget _buildEventTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppConstants.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEventLocation(String location) {
    return Row(
      children: [
        Icon(
          Icons.location_pin,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Text(
          location,
          style: const TextStyle(
            color: AppConstants.primaryTxtColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildEventDate(DateTime eventDate) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: AppConstants.primaryColor,
        ),
        SizedBox(width: 8),
        Text(
          DateFormat('dd/MM/yyyy, HH:mm').format(eventDate),
          style: const TextStyle(
            color: AppConstants.primaryTxtColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}