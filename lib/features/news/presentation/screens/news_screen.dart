import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/features/news/domain/get_news_usecase.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_event.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_state.dart';
import 'package:uasd_app/features/news/presentation/widgets/news_list_widget.dart';
import 'package:uasd_app/injection_container.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final String imageUrl =
      'https://uasd.edu.do/wp-content/uploads/ca934079-3f60-4b14-8c61-5514ad4a9fe2.jpg';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: buildTransparentAppBar(),
      drawer: HomeDrawer(),
      body: Column(
        children: [
          HeaderImage(
            imageUrl: imageUrl,
            height: screenHeight * 0.4,
            title: 'Noticias'.toUpperCase(),
          ),
          _buildNews(context: context),
        ],
      ),
    );
  }

  // Construye las noticias
  Widget _buildNews({required BuildContext context}) {
    return Expanded(
      child: BlocProvider(
        create: (context) => NewsBloc(
          getNewsUsecase: getIt<GetNewsUsecase>(),
        )..add(FetchNews()),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return buildLoading();
            } else if (state is NewsLoaded) {
              return NewsListWidget(newsList: state.news);
            } else if (state is NewsError) {
              return buildMessageContainer(message: state.message);
            } else if (state is NoNews) {
              return buildMessageContainer(
                  message: 'No hay noticias disponibles');
            } else {
              return buildMessageContainer(
                  message: 'No hay noticias disponibles');
            }
          },
        ),
      ),
    );
  }
}
