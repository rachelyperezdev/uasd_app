import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/data/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsModel> newsList;

  const NewsListWidget({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () => _launchUrl(context, news.url),
            child: _buildNewsItem(context, news, screenHeight),
          ),
        );
      },
    );
  }

  // Item para cada noticia
  Widget _buildNewsItem(
      BuildContext context, NewsModel news, double screenHeight) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            news.img,
            width: double.infinity,
            height: screenHeight * 0.4,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: screenHeight * 0.4,
                color: AppConstants.primaryColor,
                child: Icon(
                  Icons.broken_image,
                  color: AppConstants.secondaryColor,
                  size: 50,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 12.0,
          right: 12.0,
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  news.title,
                  style: TextStyle(
                    color: AppConstants.tertiaryTxtColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  news.date,
                  style: TextStyle(
                    color: AppConstants.tertiaryTxtColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _launchUrl(BuildContext context, String url) async {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url';
  }

  Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No se pudo abrir $url'),
        backgroundColor: Colors.red,
      ),
    );
  }
}