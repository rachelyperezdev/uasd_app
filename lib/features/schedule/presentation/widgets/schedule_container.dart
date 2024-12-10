import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_card.dart';
import 'package:uasd_app/core/widgets/text_utils.dart';
import 'package:uasd_app/data/models/schedule_model.dart';

// Contenedor para un solo horario
class ScheduleContainer extends StatefulWidget {
  final ScheduleModel schedule;

  const ScheduleContainer({super.key, required this.schedule});

  @override
  ScheduleContainerState createState() => ScheduleContainerState();
}

class ScheduleContainerState extends State<ScheduleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
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
          Flexible(
            child: buildTitle(
                title: widget.schedule.course,
                color: AppConstants.primaryColor),
          ),
          SizedBox(
            height: 16,
          ),
          buildTag(
              message: DateFormat('dd/MM/yyyy\nHH:mm')
                  .format(widget.schedule.dateHour)),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                  child: Icon(
                Icons.location_pin,
                color: AppConstants.primaryColor,
                size: 16,
              )),
              Flexible(
                  child: buildSubtitle(
                      title: '', content: widget.schedule.classroom)),
            ],
          ),
        ],
      ),
    );
  }
}