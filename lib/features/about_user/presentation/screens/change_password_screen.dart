import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_elevated_buttons.dart';
import 'package:uasd_app/core/widgets/form_fields_utils.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/core/widgets/text_utils.dart';
import 'package:uasd_app/data/models/change_password.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_event.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      appBar: _buildAppBar(),
      resizeToAvoidBottomInset: true,
      body: _buildBlocListener(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 3, 111, 234),
      iconTheme: IconThemeData(color: AppConstants.tertiaryTxtColor),
      title: Text(
        "",
        style: TextStyle(
          color: AppConstants.tertiaryTxtColor,
        ),
      ),
    );
  }

  BlocListener<ChangePasswordBloc, ChangePasswordState> _buildBlocListener(
      BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Contraseña Cambiada',
                  style: TextStyle(color: AppConstants.primaryColor),
                ),
                content: Text(
                  state.message,
                  style: TextStyle(color: AppConstants.primaryTxtColor),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(
                          context, AppConstants.aboutUserRoute);
                    },
                  ),
                ],
              );
            },
          );
        } else if (state is ChangePasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomizedSnackBar(message: state.message),
          );
        }
      },
      child: _buildChangePasswordForm(context: context),
    );
  }

  // Formulario para cambiar la contraseña
  Widget _buildChangePasswordForm({required BuildContext context}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              buildTitle(
                title: "Cambia tu contraseña",
                color: AppConstants.tertiaryTxtColor,
                fontSize: 24,
              ),
              SizedBox(height: 16),
              buildContent(
                content:
                    '¿Deseas cambiar tu constraseña? Llena los campos solicitados y pronto se cambiará.',
                color: AppConstants.quaternaryTxtColor,
              ),
              SizedBox(height: 32),
              _buildOldPasswordField(),
              SizedBox(height: 20),
              _buildNewPasswordField(),
              SizedBox(height: 20),
              _buildConfirmPasswordField(),
              SizedBox(height: 20),
              buildElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final oldPassword = oldPasswordController.text;
                    final newPassword = newPasswordController.text;
                    final confirmPassword = confirmPasswordController.text;

                    final ChangePasswordRequest request = ChangePasswordRequest(
                      oldPassword: oldPassword,
                      newPassword: newPassword,
                      confirmPassword: confirmPassword,
                    );

                    context.read<ChangePasswordBloc>().add(
                          ChangePasswordButtonPressed(
                            request: request,
                          ),
                        );
                  }
                },
                text: 'Cambiar Contraseña',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Campo para la contraseña antigua
  Widget _buildOldPasswordField() {
    return buildTxtFormField(
      controller: oldPasswordController,
      labelText: 'Contraseña Actual',
      errorMessage: 'Debe ingresar su contraseña actual',
      isTextObscured: true,
    );
  }

  // Campo para la nueva contraseña
  Widget _buildNewPasswordField() {
    return buildTxtFormField(
      controller: newPasswordController,
      labelText: 'Nueva Contraseña',
      errorMessage: 'Debe ingresar su nueva contraseña',
      isTextObscured: true,
    );
  }

  // Campo para confirmar las contraseñas
  Widget _buildConfirmPasswordField() {
    return ConfirmPasswordField(
      newPasswordController: newPasswordController,
      confirmPasswordController: confirmPasswordController,
    );
  }
}

// Confirmaciones

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  ConfirmPasswordField({
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.confirmPasswordController,
      cursorColor: AppConstants.tertiaryTxtColor,
      cursorErrorColor: AppConstants.tertiaryTxtColor,
      obscureText: true,
      style: TextStyle(color: AppConstants.tertiaryTxtColor),
      decoration: InputDecoration(
        labelText: 'Confirmación de Contraseña',
        labelStyle: TextStyle(
          color: AppConstants.tertiaryTxtColor,
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
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Debe ingresar la confirmación de la contraseña';
        }

        if (value != widget.newPasswordController.text) {
          return 'Las contraseñas no coinciden';
        }
        return null;
      },
    );
  }
}
