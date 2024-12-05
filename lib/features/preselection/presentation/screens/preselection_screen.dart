import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/gradient_container.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/features/preselection/domain/get_courses_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_state.dart';
import 'package:uasd_app/features/preselection/presentation/widgets/courses_container.dart';
import 'package:uasd_app/injection_container.dart';

// Preselección
class PreselectionScreen extends StatefulWidget {
  PreselectionScreen({super.key});

  @override
  PreselectionScreenState createState() => PreselectionScreenState();
}

class PreselectionScreenState extends State<PreselectionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: _buildPreselecitionAppBar(),
      drawer: HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderImage(
                imageUrl:
                    'https://img.freepik.com/foto-gratis/lista-verificacion-3d-procesamiento-portapapeles-ilustracion_107791-16457.jpg?t=st=1733091234~exp=1733094834~hmac=459113578262321dee03c4616a84e24b78697260aeadec940a164433027b4e8c&w=740',
                height: size.height * 0.4,
                title: 'Preselección'.toUpperCase()),
            buildGradientContainer(
                title1: 'Asignaturas', title2: 'Disponibles'),
            _buildCourses(height: size.height),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  // App Bar personalizada para la preselección
  AppBar _buildPreselecitionAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppConstants.primaryColor, size: 30.0),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, AppConstants.preselectionStatusRoute);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  backgroundColor: AppConstants.primaryColor),
              child: Text('Ver Preselección',
                  style: TextStyle(color: AppConstants.tertiaryTxtColor))),
        ),
      ],
    );
  }

  // Muestra las materias disponibles
  Widget _buildCourses({required double height}) {
    return BlocProvider(
      create: (context) =>
          CoursesBloc(coursesUsecase: getIt<GetCoursesUsecase>())
            ..add(FetchCourses()),
      child: BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state) {
        if (state is CoursesLoading) {
          return buildLoading();
        } else if (state is CoursesLoaded) {
          return CoursesContainer(courses: state.courses);
        } else if (state is CoursesError) {
          return buildMessageContainer(
            message: state.message,
          );
        } else if (state is NoCourses) {
          return buildMessageContainer(
              message: 'No hay asignaturas disponibles.');
        } else {
          return buildMessageContainer(
              message: 'No hay asignaturas disponibles.');
        }
      }),
    );
  }
}
