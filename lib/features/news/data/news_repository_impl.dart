import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/news_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiClient apiClient;

  NewsRepositoryImpl({required this.apiClient});

  // Busca las noticias
  @override
  Future<Either<Failure, List<NewsModel>>> fetchNews() async {
    try {
      final response = await apiClient.get('/noticias');
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        final newsList = data.map((json) => NewsModel.fromJson(json)).toList();
        return Right(newsList);
      } else {
        return Left(ServerFailure('Invalid response from server.'));
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Either<Failure, T> _handleError<T>(dynamic error) {
    if (error is NetworkException) {
      return Left(
          NetworkFailure('Network issue, please check your connection.'));
    } else if (error is ServerException) {
      return Left(ServerFailure('Failed to fetch assignments, try again.'));
    } else {
      return Left(CustomFailure('An unexpected error occurred.'));
    }
  }
}