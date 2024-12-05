import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme:
            IconThemeData(color: AppConstants.tertiaryTxtColor, size: 30.0),
      ),
      drawer: HomeDrawer(),
      body: Column(
        children: [
          HeaderImage(
            imageUrl:
                'https://uasd.edu.do/wp-content/uploads/ca934079-3f60-4b14-8c61-5514ad4a9fe2.jpg',
            height: screenHeight * 0.4,
            title: 'Noticias'.toUpperCase(),
          ),
          Expanded(
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
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: AppConstants.primaryTxtColor,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No hay noticias disponibles.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppConstants.primaryTxtColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
