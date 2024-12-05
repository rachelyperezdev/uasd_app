import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/app/app_router.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debts_bloc.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_bloc.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_bloc.dart';
import 'package:uasd_app/injection_container.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
          BlocProvider<ResetPasswordBloc>(
              create: (context) => getIt<ResetPasswordBloc>()),
          BlocProvider<UserBloc>(create: (context) => getIt<UserBloc>()),
          BlocProvider<NewsBloc>(create: (context) => getIt<NewsBloc>()),
          BlocProvider<VideoBloc>(create: (context) => getIt<VideoBloc>()),
          BlocProvider<EventsBloc>(create: (context) => getIt<EventsBloc>()),
          BlocProvider<DebtsBloc>(create: (context) => getIt<DebtsBloc>()),
          BlocProvider<ApplicationBloc>(
              create: (context) => getIt<ApplicationBloc>()),
          BlocProvider<AddApplicationBloc>(
              create: (context) => getIt<AddApplicationBloc>()),
          BlocProvider<ApplicationTypesBloc>(
              create: (context) => getIt<ApplicationTypesBloc>()),
          BlocProvider<DeleteApplicationBloc>(
              create: (context) => getIt<DeleteApplicationBloc>()),
          BlocProvider<CoursesBloc>(create: (context) => getIt<CoursesBloc>()),
          BlocProvider<PreselectionBloc>(
              create: (context) => getIt<PreselectionBloc>()),
          BlocProvider<DeletePreselectionBloc>(
              create: (context) => getIt<DeletePreselectionBloc>()),
          BlocProvider<AddPreselectionBloc>(
              create: (context) => getIt<AddPreselectionBloc>()),
          BlocProvider<ScheduleBloc>(
              create: (context) => getIt<ScheduleBloc>()),
          BlocProvider<LogoutBloc>(create: (context) => getIt<LogoutBloc>()),
          BlocProvider<UserDataBloc>(
              create: (context) => getIt<UserDataBloc>()),
          BlocProvider<ChangePasswordBloc>(
              create: (context) => getIt<ChangePasswordBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UASD APP',
          theme: ThemeData(textTheme: GoogleFonts.grenzeTextTheme()),
          initialRoute: AppConstants.initialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        ));
  }
}
