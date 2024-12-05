import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/form_fields_utils.dart';
import 'package:uasd_app/core/widgets/launch_url.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/core/widgets/customized_elevated_buttons.dart';
import 'package:uasd_app/core/widgets/text_utils.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_state.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_event.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.reset();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppConstants.primaryColor,
        appBar: _buildAppBar(),
        resizeToAvoidBottomInset: true,
        body: _buildBlocListener(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 3, 111, 234),
      iconTheme: IconThemeData(color: AppConstants.tertiaryTxtColor),
      title: Text(
        "Iniciar Sesión",
        style: TextStyle(
          color: AppConstants.tertiaryTxtColor,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppConstants.landingRoute);
        },
      ),
    );
  }

  BlocListener<LoginBloc, LoginState> _buildBlocListener() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context
              .read<UserBloc>()
              .add(SetUser(state.user)); // establecer el usuario
          Navigator.pushReplacementNamed(
              context, AppConstants.homeRoute); // ir a home
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomizedSnackBar(
              message:
                  state.error, // mensaje de error en caso de no poder loggearse
            ),
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
                  title: "Bienvenido a la UASD",
                  color: AppConstants.tertiaryTxtColor,
                  fontSize: 24,
                ),
                SizedBox(height: 16),
                buildContent(
                  content:
                      'Estamos encantados de tenerte aquí. Inicia sesión para acceder a todos nuestros servicios y recursos.',
                  color: AppConstants.quaternaryTxtColor,
                ),
                SizedBox(height: 32),
                _buildUsernameField(),
                SizedBox(height: 20),
                _buildPasswordField(),
                SizedBox(height: 20),
                buildElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      context.read<LoginBloc>().add(LogingButtonPressed(
                            username: username,
                            password: password,
                          ));
                    }
                  },
                  text: 'Iniciar Sesión',
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: _buildRedirectionBtn(
                            context: context,
                            text: 'Estudia con nosotros',
                            url: 'https://uasd.edu.do/admisiones/')),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(child: _buildResetPasswordButton()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return buildTxtFormField(
      controller: usernameController,
      labelText: 'Usuario',
      errorMessage: 'Debe ingresar un nombre de usuario',
    );
  }

  Widget _buildPasswordField() {
    return buildTxtFormField(
      controller: passwordController,
      labelText: 'Contraseña',
      errorMessage: 'Debe ingresar una contraseña',
      isTextObscured: true,
    );
  }

  Widget _buildResetPasswordButton() {
    return ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, AppConstants.resetPasswordRoute)
              .then((_) {
            _formKey.currentState?.reset();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 2, 117, 249),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          'Restablecer Contraseña',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppConstants.tertiaryTxtColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ));
  }

  Widget _buildRedirectionBtn(
      {required BuildContext context,
      required String text,
      required String url}) {
    return ElevatedButton(
        onPressed: () => openUrl(context, url),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 2, 117, 249),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppConstants.tertiaryTxtColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ));
  }
}
