import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/features/about_developers/presentation/screens/about_developers_screen.dart';
import 'package:uasd_app/features/about_user/presentation/screens/about_user_screen.dart';
import 'package:uasd_app/features/applications/presentation/screens/add_application_screen.dart';
import 'package:uasd_app/features/applications/presentation/screens/applications_screen.dart';
import 'package:uasd_app/features/assignments/presentation/screens/assignments_screen.dart';
import 'package:uasd_app/features/auth/presentation/screens/login_screen.dart';
import 'package:uasd_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:uasd_app/features/debt/presentation/screens/debt_screen.dart';
import 'package:uasd_app/features/events/presentation/screens/events_screen.dart';
import 'package:uasd_app/features/home/presentation/screens/home_screen.dart';
import 'package:uasd_app/features/landing/presentation/screens/landing_screen.dart';
import 'package:uasd_app/features/news/presentation/screens/news_screen.dart';
import 'package:uasd_app/features/preselection/presentation/screens/preselection_screen.dart';
import 'package:uasd_app/features/preselection/presentation/screens/preselection_status_screen.dart';
import 'package:uasd_app/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:uasd_app/features/videos/presentation/screens/videos_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.initialRoute:
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case AppConstants.aboutDevelopersRoute:
        return MaterialPageRoute(builder: (_) => AboutDevelopersScreen());
      case AppConstants.aboutUserRoute:
        return MaterialPageRoute(builder: (_) => AboutUserScreen());
      case AppConstants.addApplicationRoute:
        return MaterialPageRoute(builder: (_) => AddApplicationScreen());
      case AppConstants.applicationsRoute:
        return MaterialPageRoute(builder: (_) => ApplicationsScreen());
      case AppConstants.assignmentsRoute:
        return MaterialPageRoute(builder: (_) => AssignmentsScreen());
      case AppConstants.debtsRoute:
        return MaterialPageRoute(builder: (_) => DebtsScreen());
      case AppConstants.eventsRoute:
        return MaterialPageRoute(builder: (_) => EventsScreen());
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppConstants.landingRoute:
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case AppConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppConstants.newsRoute:
        return MaterialPageRoute(builder: (_) => NewsScreen());
      case AppConstants.preselectionRoute:
        return MaterialPageRoute(builder: (_) => PreselectionScreen());
      case AppConstants.preselectionStatusRoute:
        return MaterialPageRoute(builder: (_) => PreselectionStatusScreen());
      case AppConstants.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case AppConstants.scheduleRoute:
        return MaterialPageRoute(builder: (_) => ScheduleScreen());
      case AppConstants.videosRoute:
        return MaterialPageRoute(builder: (_) => VideosScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Ruta no definida ${settings.name}')),
          ),
        );
    }
  }
}
