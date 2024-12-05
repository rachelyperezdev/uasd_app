import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/core/widgets/customized_elevated_buttons.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/features/about_user/domain/get_userData_usecase.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_bloc.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_event.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_state.dart';
import 'package:uasd_app/features/about_user/presentation/screens/change_password_screen.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/injection_container.dart';

class AboutUserScreen extends StatelessWidget {
  AboutUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      appBar: buildLightAppBar(title: 'Sobre el usuario'),
      drawer: HomeDrawer(),
      body: Column(
        children: [_buildUserContainer()],
      ),
    );
  }

  // Proveedor de BLoC para determinar en que estado se encuentra para mostrar
  // en la UI
  Widget _buildUserContainer() {
    return Expanded(
      child: BlocProvider(
        create: (context) =>
            UserDataBloc(userdataUsecase: getIt<GetUserdataUsecase>())
              ..add(FetchUserData()),
        child: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoading) {
              return buildLoading();
            } else if (state is UserDataLoaded) {
              return _buildUserData(context: context, user: state.user);
            } else if (state is UserDataError) {
              return buildMessageContainer(message: state.message);
            } else {
              return buildMessageContainer(
                  message: 'No se pudieron obtener los datos del usuario');
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _buildUserData(
      {required BuildContext context, required UserModel user}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),
          _buildUserInitialCircle(user),
          _buildUserInfoContainer(context, user),
        ],
      ),
    );
  }

  // Círculo con la primera letra del nombre del usuario
  Widget _buildUserInitialCircle(UserModel user) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 232, 243, 255),
            const Color.fromARGB(255, 225, 239, 255)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.08),
            spreadRadius: 4,
            blurRadius: 12,
            offset: Offset(3, 3),
          ),
        ],
        shape: BoxShape.circle,
        border: Border.all(
          color: AppConstants.primaryColor,
          width: 0.2,
        ),
      ),
      child: Center(
        child: Text(
          user.nombre[0],
          style: TextStyle(
            fontSize: 40,
            color: AppConstants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Contenedor de la información del usuario
  Widget _buildUserInfoContainer(BuildContext context, UserModel user) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 350,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMessageContainer(
                message: "${user.nombre} ${user.apellido}", icon: Icons.person),
            buildMessageContainer(message: user.username, icon: Icons.school),
            buildMessageContainer(message: user.email, icon: Icons.email),
            buildRedirectionBtn(
                onPressed: () =>
                    _navigateToChangePasswordScreen(context: context),
                text: 'Cambiar Contraseña')
          ],
        ),
      ),
    );
  }

  // Redirección a la pantalla de `cambio de contraseña`
  void _navigateToChangePasswordScreen({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordScreen(),
      ),
    );
  }
}
