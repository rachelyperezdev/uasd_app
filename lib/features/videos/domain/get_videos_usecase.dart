import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/video_model.dart';
import 'package:uasd_app/features/videos/domain/repositories/videos_repository.dart';

class GetVideosUsecase {
  final VideosRepository videosRepository;

  GetVideosUsecase({required this.videosRepository});

  Future<Either<Failure, List<VideoModel>>> execute() async {
    return await videosRepository.fetchVideos();
  }
}
