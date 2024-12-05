import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/preselection/domain/get_courses_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCoursesUsecase coursesUsecase;

  CoursesBloc({required this.coursesUsecase}) : super(CoursesInitial()) {
    on<FetchCourses>(_onFetchCourses);
  }

  Future<void> _onFetchCourses(
      FetchCourses event, Emitter<CoursesState> emit) async {
    emit(CoursesLoading());

    final result = await coursesUsecase.execute();

    result.fold(
        (failure) =>
            CoursesError(message: 'No se pudieron obtener las materias.'),
        (courses) {
      if (courses.isEmpty) {
        return emit(NoCourses());
      } else {
        return emit(CoursesLoaded(courses: courses));
      }
    });
  }
}
