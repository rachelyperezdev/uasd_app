import 'package:equatable/equatable.dart';

class DeleteApplicationEvent extends Equatable {
  final int applicationId;

  const DeleteApplicationEvent({required this.applicationId});

  @override
  List<Object?> get props => [applicationId];
}

