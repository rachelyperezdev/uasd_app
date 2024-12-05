import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NoNews extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;

  const NewsLoaded({required this.news});

  @override
  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  const NewsError({required this.message});

  @override
  List<Object> get props => [message];
}