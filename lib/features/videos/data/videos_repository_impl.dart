import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/core/errors/network_exception.dart';
import 'package:uasd_app/core/errors/server_exception.dart';
import 'package:uasd_app/data/models/video_model.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/videos/domain/repositories/videos_repository.dart';

class VideosRepositoryImpl extends VideosRepository {
  final ApiClient apiClient;

  VideosRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<VideoModel>>> fetchVideos() async {
    try {
      final response = await apiClient.get('/videos');

      if (response.isEmpty) {
        return Left(CustomFailure('No videos found.'));
      }

      final List<dynamic> data = response as List<dynamic>;

      final List<VideoModel> videos =
          data.map((json) => VideoModel.fromJson(json)).toList();

      return Right(videos);
    } catch (error) {
      if (error is NetworkException) {
        return Left(
            NetworkFailure('Network issue, please check your connection.'));
      } else if (error is ServerException) {
        return Left(ServerFailure('Failed to fetch news, try again.'));
      } else {
        return Left(CustomFailure('An unexpected error occurred.'));
      }
    }
  }
}