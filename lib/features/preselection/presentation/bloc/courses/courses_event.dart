import 'package:equatable/equatable.dart';

abstract class CoursesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCourses extends CoursesEvent {}
