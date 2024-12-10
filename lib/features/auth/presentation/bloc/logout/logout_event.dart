import 'package:equatable/equatable.dart';

// Eventos de cierre de sesión
abstract class LogoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogoutButtonPressed extends LogoutEvent {}
