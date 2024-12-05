import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/core/errors/failure.dart';
import 'package:uasd_app/data/models/video_model.dart';
import 'package:uasd_app/features/videos/domain/get_videos_usecase.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_event.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideosUsecase videosUsecase;

  VideoBloc({required this.videosUsecase}) : super(VideosInitial()) {
    on<FetchVideos>(_onFetchVideos);
  }

  void _onFetchVideos(FetchVideos event, Emitter<VideoState> emit) async {
    emit(VideosLoading()); // cargando

    final Either<Failure, List<VideoModel>> result =
        await videosUsecase.execute(); // llama al caso de uso

    // emite
    emit(result.fold(
        (failure) => VideosError(message: 'No se pudieron cargar los videos.'),
        (videos) => VideosLoaded(videos: videos)));
  }
}