import 'package:equatable/equatable.dart';

class DeletePreselectionEvent extends Equatable {
  final String courseCode;

  const DeletePreselectionEvent({required this.courseCode});

  @override
  List<Object?> get props => [courseCode];
}
