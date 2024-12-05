import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_card.dart';
import 'package:uasd_app/core/widgets/customized_dialogs.dart';
import 'package:uasd_app/data/models/course_model.dart';
import 'package:uasd_app/data/models/preselection_model.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_state.dart';
import 'package:uasd_app/features/preselection/presentation/screens/detail_course_screen.dart';

class CoursesContainer extends StatefulWidget {
  final List<CourseModel> courses;

  CoursesContainer({super.key, required this.courses});

  @override
  CoursesContainerState createState() => CoursesContainerState();
}

class CoursesContainerState extends State<CoursesContainer> {
  @override
  Widget build(BuildContext context) {
    return _buildBlocListener(courses: widget.courses);
  }

  BlocListener<AddPreselectionBloc, AddPreselectionState> _buildBlocListener(
      {required List<CourseModel> courses}) {
    return BlocListener<AddPreselectionBloc, AddPreselectionState>(
      listener: _handleBlocState,
      child: Column(
        children: courses.map((course) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildCourseCard(context: context, course: course),
          );
        }).toList(),
      ),
    );
  }

  void _handleBlocState(BuildContext context, AddPreselectionState state) {
    if (state is AddPreselectionLoading) {
      _showLoadingDialog();
    } else if (state is AddPreselectionLoaded) {
      _onAddCourseSuccess();
    } else if (state is AddPreselectionError) {
      _onPreselectionError(state.message);
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: buildLoading()),
    );
  }

  void _onAddCourseSuccess() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'La asignatura ha sido preseleccionada exitosamente',
          style: TextStyle(color: AppConstants.tertiaryTxtColor),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
  }

  void _onPreselectionError(String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppConstants.tertiaryTxtColor),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
  }

  // card del curso
  Widget _buildCourseCard(
      {required BuildContext context, required CourseModel course}) {
    return GestureDetector(
      onTap: () => _navigateToDetailCourseScreen(context, course),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: buildCardDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCourseHeader(context: context, course: course),
                SizedBox(height: 8),
                buildTag(message: course.code),
                SizedBox(height: 8),
                buildSubtitle(
                  title: course.name,
                  content: '',
                ),
                buildSubtitle(
                  title: 'Aula: ',
                  content: course.classroom,
                ),
                buildSubtitle(title: 'Horario: ', content: course.schedule),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // redirige a la pantalla de detalle de la asignatura y muestra en el mapa
  // donde se ubica
  void _navigateToDetailCourseScreen(BuildContext context, CourseModel course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailCourseScreen(course: course),
      ),
    );
  }

  // encabezado de la asignatura
  Widget _buildCourseHeader(
      {required BuildContext context, required CourseModel course}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            course.name,
            style: const TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () =>
                  _showAddCourseDialog(context: context, course: course),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: AppConstants.primaryColor,
              ),
              child: Text(
                'Agregar',
                style: TextStyle(
                  color: AppConstants.tertiaryTxtColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // muestra el diálogo para agregar curso
  void _showAddCourseDialog(
      {required BuildContext context, required CourseModel course}) async {
    if (!mounted) return;

    final newPreselection = CreatePreselectionModel(courseCode: course.code);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDialog(
            course: course,
            onConfirm: () {
              context
                  .read<AddPreselectionBloc>()
                  .add(AddPreselectionEvent(addPreselection: newPreselection));
            },
            title: 'Preseleccionar Asignatura',
            description:
                '¿Está seguro de que desea preseleccion la asignatura "${course.name}"?',
            actionBtnTitle: 'Confirmar');
      },
    );
  }
}
