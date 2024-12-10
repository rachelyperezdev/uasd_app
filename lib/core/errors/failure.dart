import 'package:equatable/equatable.dart';

// Fallo Base

abstract class Failure extends Equatable {
  final String? message;

  const Failure([this.message]);

  @override
  List<Object?> get props => [message];
}

// Fallos Generales

class ServerFailure extends Failure {
  final String? message;

  const ServerFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String? message;

  const CacheFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  final String? fieldName;
  final String? message;

  const ValidationFailure([this.fieldName, this.message]);

  @override
  List<Object?> get props => [fieldName, message];
}

class NetworkFailure extends Failure {
  final String? message;

  const NetworkFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

class CustomFailure extends Failure {
  final String? message;

  const CustomFailure([this.message]);

  @override
  List<Object?> get props => [message];
}
