import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetPasswordButtonPressed extends ResetPasswordEvent {
  final String usuario;
  final String email;

  ResetPasswordButtonPressed({required this.usuario, required this.email});

  @override
  List<Object?> get props => [usuario, email];
}
