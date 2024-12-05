import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogingButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LogingButtonPressed({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
