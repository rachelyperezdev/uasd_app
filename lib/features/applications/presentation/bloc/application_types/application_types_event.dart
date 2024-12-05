import 'package:equatable/equatable.dart';

abstract class ApplicationTypesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchApplicationTypes extends ApplicationTypesEvent {}
