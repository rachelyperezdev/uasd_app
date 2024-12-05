import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/user_model.dart';

class UserState extends Equatable {
  final UserModel? user;

  const UserState({this.user});

  @override
  List<Object?> get props => [user];
}
