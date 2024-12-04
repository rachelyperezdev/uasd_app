import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/app/app_router.dart';
import 'package:uasd_app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        providers: [],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UASD APP',
          theme: ThemeData(textTheme: GoogleFonts.grenzeTextTheme()),
          initialRoute: AppConstants.initialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        ));
  }
}
