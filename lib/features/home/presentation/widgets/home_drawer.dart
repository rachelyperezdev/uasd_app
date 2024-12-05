import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/data/models/user_model.dart';
import 'package:uasd_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/logout/logout_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_state.dart';

// Sidemenu
class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        final UserModel? user = state.user;

        if (user == null) {
          return Center(
            child: Text("Error al obtener la data del usuario"),
          );
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppConstants.primaryColor),
              accountName: Text(
                '${user.nombre} ${user.apellido}',
                style: TextStyle(color: AppConstants.tertiaryTxtColor),
              ),
              accountEmail: Text(
                user.email,
                style: TextStyle(color: AppConstants.tertiaryTxtColor),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppConstants.tertiaryTxtColor,
                child: Text(
                  user.nombre[0].toUpperCase(),
                  style:
                      TextStyle(fontSize: 40, color: AppConstants.primaryColor),
                ),
              ),
            ),
            ...AppConstants.screens.map((screen) {
              return _buildDrawerItem(
                icon: AppConstants.screenIcons[screen]!,
                text: screen,
                onTap: () {
                  if (screen == 'Cerrar Sesión') {
                    BlocProvider.of<LogoutBloc>(context)
                        .add(LogoutButtonPressed());
                    Navigator.pushReplacementNamed(
                        context, AppConstants.screenRoutes[screen]!);
                  } else {
                    _navigateTo(context, AppConstants.screenRoutes[screen]!);
                  }
                },
              );
            }).toList(),
          ],
        );
      }),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppConstants.primaryColor,
      ),
      title: Text(
        text,
        style: TextStyle(color: AppConstants.primaryColor),
      ),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName);
  }
}
