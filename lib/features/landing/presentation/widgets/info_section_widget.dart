import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/text_utils.dart';
import 'package:uasd_app/features/landing/presentation/widgets/image_viewer.dart';
import 'package:uasd_app/core/widgets/video_player_widget.dart';

class InfoSectionWidget extends StatefulWidget {
  const InfoSectionWidget({super.key});

  @override
  InfoSectionState createState() => InfoSectionState();
}

class InfoSectionState extends State<InfoSectionWidget>
    with SingleTickerProviderStateMixin {
  late CarouselSliderController innerCarouselController;
  int innerCurrentPage = 0;

  @override
  void initState() {
    innerCarouselController = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(title: 'Sobre la ${AppConstants.appTitle}'),
          SizedBox(height: 6.0),
          buildUnderline(width: 100.0, height: 2.0),
          SizedBox(height: 18.0),
          buildContent(content: AppConstants.aboutUASD),
          SizedBox(height: 20),
          VideoPlayerWidget(videoId: 'foK1vNrhRgU'),
          SizedBox(height: 18.0),
          buildTitle(title: 'Misión'),
          SizedBox(height: 6.0),
          buildUnderline(width: 50.0, height: 2.0),
          SizedBox(height: 18.0),
          buildContent(content: AppConstants.missionUASD),
          SizedBox(height: 20),
          buildTitle(title: 'Visión'),
          SizedBox(height: 6.0),
          buildUnderline(width: 50.0, height: 2.0),
          SizedBox(height: 18.0),
          buildContent(content: AppConstants.visionUASD),
          SizedBox(height: 20),
          buildTitle(title: 'Valores'),
          SizedBox(height: 6.0),
          buildUnderline(width: 50.0, height: 2.0),
          SizedBox(height: 18.0),
          _buildValuesWrap(context, AppConstants.valuesUASD),
          SizedBox(height: 20.0),
          buildTitle(title: 'Imágenes'),
          SizedBox(height: 6.0),
          buildUnderline(width: 65.0, height: 2.0),
          SizedBox(height: 18.0),
          _innerBannerSlider(height, width),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildValuesWrap(BuildContext context, List<String> values) {
    if (values.isEmpty) {
      return Text(
        'No pudimos obtener los valores disponibles.',
        style: TextStyle(
          color: AppConstants.primaryTxtColor,
          fontSize: 16,
        ),
      );
    } else {
      return Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children:
            values.map((value) => _buildValueItem(context, value)).toList(),
      );
    }
  }

  Widget _buildValueItem(BuildContext context, String value) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            color: AppConstants.tertiaryTxtColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _innerBannerSlider(double height, double width) {
    double sliderHeight;

    if (width > 1200) {
      sliderHeight = height * 0.6;
    } else if (width > 800) {
      sliderHeight = height * 0.4;
    } else {
      sliderHeight = height * 0.25;
    }

    return Column(
      children: [
        SizedBox(
          height: sliderHeight,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                  child: CarouselSlider(
                carouselController: innerCarouselController,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    aspectRatio: 16 / 8,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        innerCurrentPage = index;
                      });
                    }),
                items: AppConstants.imagesUASD.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return CustomImageViewer.show(
                        context: context,
                        url: imagePath,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                }).toList(),
              )),
            ],
          ),
        )
      ],
    );
  }
}
