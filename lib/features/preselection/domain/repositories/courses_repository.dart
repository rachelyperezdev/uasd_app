import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/course_model.dart';

abstract class CoursesRepository {
  Future<Either<Failure, List<CourseModel>>> fetchCourses();
}
