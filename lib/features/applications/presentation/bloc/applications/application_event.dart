import 'package:equatable/equatable.dart';

abstract class ApplicationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchApplications extends ApplicationEvent {}
