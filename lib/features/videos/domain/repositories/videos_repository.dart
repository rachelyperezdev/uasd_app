import 'package:dartz/dartz.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/video_model.dart';

abstract class VideosRepository {
  Future<Either<Failure, List<VideoModel>>> fetchVideos();
}