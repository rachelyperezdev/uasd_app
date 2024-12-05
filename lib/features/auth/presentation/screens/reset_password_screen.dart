import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/form_fields_utils.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/core/widgets/customized_elevated_buttons.dart';
import 'package:uasd_app/core/widgets/text_utils.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      appBar: buildDarkAppBar(title: ""),
      resizeToAvoidBottomInset: true,
      body: _buildBlocListener(context),
    );
  }

  BlocListener<ResetPasswordBloc, ResetPasswordState> _buildBlocListener(
      BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Contraseña Restablecida',
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
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              );
            },
          );
        } else if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomizedSnackBar(message: state.error),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                buildTitle(
                  title: "Restablece tu contraseña",
                  color: AppConstants.tertiaryTxtColor,
                  fontSize: 24,
                ),
                SizedBox(height: 16),
                buildContent(
                  content:
                      '¿Olvidaste tu contraseña? No te preocupes, llena los campos solicitados y te ayudaremos a restablecerla.',
                  color: AppConstants.quaternaryTxtColor,
                ),
                SizedBox(height: 32),
                _buildUsuarioField(),
                SizedBox(height: 20),
                _buildEmailField(),
                SizedBox(height: 20),
                buildElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final usuario = usuarioController.text;
                      final email = emailController.text;
                      context.read<ResetPasswordBloc>().add(
                            ResetPasswordButtonPressed(
                              usuario: usuario,
                              email: email,
                            ),
                          );
                    }
                  },
                  text: 'Restablecer Contraseña',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsuarioField() {
    return buildTxtFormField(
      controller: usuarioController,
      labelText: 'Usuario',
      errorMessage: 'Debe ingresar un usuario',
    );
  }

  Widget _buildEmailField() {
    return buildTxtFormField(
      controller: emailController,
      labelText: 'Email',
      errorMessage: 'Debe ingresar un correo',
    );
  }
}
