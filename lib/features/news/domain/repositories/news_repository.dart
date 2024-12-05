import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/news_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsModel>>> fetchNews();
}