import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/application_model.dart';

class AddApplicationEvent extends Equatable {
  final CreateApplicationModel addApplication;

  const AddApplicationEvent({required this.addApplication});

  @override
  List<Object?> get props => [addApplication];
}
