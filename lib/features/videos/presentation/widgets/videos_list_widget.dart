import 'package:flutter/material.dart';
import 'package:uasd_app/core/widgets/video_player_widget.dart';
import 'package:uasd_app/data/models/video_model.dart';

class VideosListWidget extends StatelessWidget {
  final List<VideoModel> videosList;

  const VideosListWidget({super.key, required this.videosList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: videosList.length,
        itemBuilder: (context, index) {
          final video = videosList[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: VideoPlayerWidget(videoId: video.url),
          );
        });
  }
}
