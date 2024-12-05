import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/news_model.dart';
import 'package:uasd_app/features/news/domain/get_news_usecase.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_event.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUsecase getNewsUsecase;

  NewsBloc({required this.getNewsUsecase}) : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
  }

  void _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading()); // carga
    final Either<Failure, List<NewsModel>> result =
        await getNewsUsecase.execute(); // llama caso de uso

    // emite
    emit(result.fold(
        (failure) => NewsError(message: 'No se pudieron cargar las noticias.'),
        (news) {
      if (news.isEmpty) {
        return NoNews();
      } else {
        return NewsLoaded(news: news);
      }
    }));
  }
}