// Eventos de cierre de sesión
import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogoutButtonPressed extends LogoutEvent {}
