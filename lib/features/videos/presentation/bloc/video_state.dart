import 'package:equatable/equatable.dart';
import 'package:uasd_app/data/models/video_model.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideosInitial extends VideoState {}

class VideosLoading extends VideoState {}

class VideosLoaded extends VideoState {
  final List<VideoModel> videos;

  const VideosLoaded({required this.videos});

  @override
  List<Object?> get props => [videos];
}

class VideosError extends VideoState {
  final String message;

  const VideosError({required this.message});

  @override
  List<Object?> get props => [message];
}