import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/news_model.dart';
import 'package:uasd_app/features/news/domain/repositories/news_repository.dart';

class GetNewsUsecase {
  final NewsRepository newsRepository;

  GetNewsUsecase({required this.newsRepository});

  Future<Either<Failure, List<NewsModel>>> execute() async {
    return await newsRepository.fetchNews();
  }
}