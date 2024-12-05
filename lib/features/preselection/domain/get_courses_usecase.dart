import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/course_model.dart';
import 'package:uasd_app/features/preselection/domain/repositories/courses_repository.dart';

class GetCoursesUsecase {
  final CoursesRepository coursesRepository;

  GetCoursesUsecase({required this.coursesRepository});

  Future<Either<Failure, List<CourseModel>>> execute() async {
    return coursesRepository.fetchCourses();
  }
}
