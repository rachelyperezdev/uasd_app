import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:uasd_app/features/landing/presentation/widgets/image_viewer.dart';


// Slider
class InnerBannerSlider extends StatelessWidget {
  final CarouselSliderController carouselController;
  final int currentPage;
  final List<String> imagePaths;
  final double height;
  final double width;

  const InnerBannerSlider({
    Key? key,
    required this.carouselController,
    required this.currentPage,
    required this.imagePaths,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    aspectRatio: 16 / 8,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {},
                  ),
                  items: imagePaths.map((imagePath) {
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}