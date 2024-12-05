import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/features/videos/domain/get_videos_usecase.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_bloc.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_event.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_state.dart';
import 'package:uasd_app/features/videos/presentation/widgets/videos_list_widget.dart';
import 'package:uasd_app/injection_container.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  VideosState createState() => VideosState();
}

class VideosState extends State<VideosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppConstants.primaryBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppConstants.primaryColor, size: 30.0),
      ),
      drawer: HomeDrawer(),
      body: Column(
        children: [
          HeaderImage(
            imageUrl:
                'https://eldinero.com.do/wp-content/uploads/eduaction-uasd.jpg',
            height: screenHeight * 0.4,
            title: 'VIDEOS',
          ),
          _buildVideos(context: context),
        ],
      ),
    );
  }

  // Videos
  Widget _buildVideos({required BuildContext context}) {
    return Expanded(
      child: BlocProvider(
        create: (context) => VideoBloc(videosUsecase: getIt<GetVideosUsecase>())
          ..add(FetchVideos()),
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideosLoading) {
              return buildLoading();
            } else if (state is VideosLoaded) {
              return VideosListWidget(videosList: state.videos);
            } else if (state is VideosError) {
              return buildMessageContainer(message: state.message);
            } else {
              return buildMessageContainer(
                  message: 'No hay videos disponibles');
            }
          },
        ),
      ),
    );
  }
}
