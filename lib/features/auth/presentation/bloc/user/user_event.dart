import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/user_model.dart';

class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetUser extends UserEvent {
  final UserModel user;

  SetUser(this.user);

  @override
  List<Object?> get props => [user];
}

class ClearUser extends UserEvent {}
