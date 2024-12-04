// DIALOGOS

// Cancelar
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/data/models/course_model.dart';

class CancellationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String description;
  final String actionBtnTitle;

  const CancellationDialog(
      {super.key,
      required this.onConfirm,
      required this.title,
      required this.description,
      required this.actionBtnTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: TextStyle(
              color: AppConstants.primaryColor, fontWeight: FontWeight.bold)),
      content: Text(description,
          style: TextStyle(color: AppConstants.primaryTxtColor)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar',
              style: TextStyle(color: AppConstants.primaryColor)),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(actionBtnTitle,
              style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// Añadir
class AddDialog extends StatelessWidget {
  final CourseModel course;
  final VoidCallback onConfirm;
  final String title;
  final String description;
  final String actionBtnTitle;

  const AddDialog(
      {super.key,
      required this.course,
      required this.onConfirm,
      required this.title,
      required this.description,
      required this.actionBtnTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: TextStyle(
              color: AppConstants.primaryColor, fontWeight: FontWeight.bold)),
      content: Text(description,
          style: TextStyle(color: AppConstants.primaryTxtColor)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar',
              style: TextStyle(color: AppConstants.primaryColor)),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(actionBtnTitle,
              style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
