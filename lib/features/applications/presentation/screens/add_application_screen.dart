import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/form_fields_utils.dart';
import 'package:uasd_app/data/models/application_model.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_state.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_state.dart';
import 'package:uasd_app/features/applications/presentation/screens/applications_screen.dart';

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
      backgroundColor: AppConstants.primaryColor,
      appBar: buildDarkAppBar(title: 'Crear Solicitud'),
      resizeToAvoidBottomInset: true,
      body: _buildBlocListener(),
    );
  }

  BlocListener<AddApplicationBloc, AddApplicationState> _buildBlocListener() {
    return BlocListener<AddApplicationBloc, AddApplicationState>(
      listener: _handleBlocState,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  // Manejador del estado del BLoC
  void _handleBlocState(BuildContext context, AddApplicationState state) {
    if (state is AddApplicationLoading) {
      _showLoadingDialog();
    } else if (state is AddApplicationLoaded) {
      _onApplicationSuccess();
    } else if (state is AddApplicationError) {
      _onApplicationError(state.message);
    }
  }

  // Muestra un fondo gris con el indicador de progreso
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: buildLoading()),
    );
  }

  // Mensaje cuando la solicitud es exitosa
  void _onApplicationSuccess() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'La solicitud ha sido creada exitosamente',
          style: TextStyle(color: AppConstants.tertiaryTxtColor),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ApplicationsScreen()),
    );
  }

  // Mensaje cuando la solicitud fracasa
  void _onApplicationError(String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppConstants.primaryTxtColor),
        ),
        backgroundColor: AppConstants.tertiaryTxtColor,
      ),
    );
  }

  // Formulario de la Solicitud
  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApplicationTypeDropdown(),
          const SizedBox(height: 16),
          buildTxtFormField(
            controller: applicationDescriptionController,
            labelText: "Descripción",
            errorMessage: "Debe ingresar una descripción",
            maxLines: 10,
          ),
          const SizedBox(height: 20),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  // Manejador de estado de los Tipos de Solicitud
  Widget _buildApplicationTypeDropdown() {
    return BlocBuilder<ApplicationTypesBloc, ApplicationTypesState>(
      builder: (context, state) {
        if (state is ApplicationTypesLoading) {
          return buildLoading();
        } else if (state is ApplicationTypesLoaded) {
          return _buildDropdownButton(state.applicationTypes);
        } else if (state is ApplicationTypesError) {
          return Text(
            state.message,
            style: TextStyle(color: AppConstants.tertiaryTxtColor),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // Dropdown de los tipos de solicitudes
  DropdownButtonFormField2<String> _buildDropdownButton(
      List<ApplicationTypeModel> applicationTypes) {
    return DropdownButtonFormField2<String>(
      value: selectedApplicationType,
      items: applicationTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type.code,
          child: Text(type.description),
        );
      }).toList(),
      onChanged: (value) => setState(() => selectedApplicationType = value),
      dropdownStyleData: DropdownStyleData(
        width: 290,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromARGB(255, 3, 114, 241),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 78, 167).withAlpha(100),
              spreadRadius: 2,
              blurRadius: 26,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        offset: const Offset(0, 8),
      ),
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 20,
        width: 140,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        overlayColor: WidgetStatePropertyAll(Color.fromARGB(255, 20, 130, 255)),
      ),
      decoration: _buildDropdownDecoration(),
      iconStyleData: IconStyleData(
        iconEnabledColor: AppConstants.tertiaryTxtColor,
      ),
      style: TextStyle(color: AppConstants.tertiaryTxtColor),
      validator: (value) => value == null || value.isEmpty
          ? 'Por favor, seleccione un tipo de solicitud'
          : null,
    );
  }

  // Apariencia del Dropdown
  InputDecoration _buildDropdownDecoration() {
    return InputDecoration(
      labelText: 'Tipos de Solicitud',
      labelStyle: TextStyle(color: AppConstants.tertiaryTxtColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppConstants.tertiaryTxtColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.tertiaryTxtColor),
      ),
      errorStyle: TextStyle(
        color: AppConstants.tertiaryTxtColor,
        fontSize: 14,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }

  // boton para enviar
  ElevatedButton _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.tertiaryTxtColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        minimumSize: const Size(double.infinity, 50),
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
      ),
      onPressed: _submitForm,
      child: Text(
        'Enviar',
        style: TextStyle(
          color: AppConstants.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Envia el formulario
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newApplication = CreateApplicationModel(
        type: selectedApplicationType!,
        description: applicationDescriptionController.text,
      );

      context
          .read<AddApplicationBloc>()
          .add(AddApplicationEvent(addApplication: newApplication));
    }
  }
}
