import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/change_password.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final ChangePasswordRequest request;

  ChangePasswordButtonPressed({required this.request});

  @override
  List<Object?> get props => [request];
}
