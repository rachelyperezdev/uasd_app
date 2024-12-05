import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/course_model.dart';

class CoursesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<CourseModel> courses;

  CoursesLoaded({required this.courses});

  @override
  List<Object?> get props => [courses];
}

class CoursesError extends CoursesState {
  final String message;

  CoursesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NoCourses extends CoursesState {}
