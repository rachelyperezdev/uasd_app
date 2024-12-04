import 'package:flutter/material.dart';

// Pantalla de Solicitud
class AddApplicationScreen extends StatefulWidget {
  AddApplicationScreen({super.key});

  @override
  AddApplicationScreenState createState() => AddApplicationScreenState();
}

class AddApplicationScreenState extends State<AddApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController applicationDescriptionController =
      TextEditingController();
  String? selectedApplicationType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      // appBar: ,
      // drawer: ,
      body: Center(),
    );
  }
}
