import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/user_model.dart';

abstract class UserDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class NoUserData extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final UserModel user;

  UserDataLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
