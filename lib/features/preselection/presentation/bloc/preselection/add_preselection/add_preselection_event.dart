import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/preselection_model.dart';

class AddPreselectionEvent extends Equatable {
  final CreatePreselectionModel addPreselection;

  const AddPreselectionEvent({required this.addPreselection});

  @override
  List<Object?> get props => [addPreselection];
}
