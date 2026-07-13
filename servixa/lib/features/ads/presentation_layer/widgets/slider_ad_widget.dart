import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/home/business_later/home_controller.dart';

class SliderAdWidget extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final AdsModel ads;

  SliderAdWidget({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    // final widthScreen = Get.width;
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: ads.images.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return Container(
              width: size.width,
              height: 325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(21),
                  bottomRight: Radius.circular(21),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 7,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),

              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.vertical(
                  bottom: Radius.circular(21),
                ),
                child:
                    CachedNetworkImage(
                      imageUrl: ads.images[itemIndex].url,
                      placeholder: (context, url) =>
                          Image.asset(ImageApp.placeholder, fit: BoxFit.cover),
                      fit: BoxFit.cover,
                      width: size.width,
                      height: 325,
                      errorWidget: (context, url, error) {
                        return Container(
                          width: size.width,
                          height: 325,
                          color: ThemeApp.Foundation_Secendary_grey_100,
                          child: const Icon(
                            Icons.broken_image,
                            size: 30,
                            color: Colors.grey,
                          ),
                        );
                      },
                      fadeInDuration: Duration(seconds: 1),
                      fadeOutDuration: Duration(seconds: 1),
                      placeholderFadeInDuration: Duration(seconds: 1),
                    ),
              ),
            );
          },
          options: CarouselOptions(
            height: 325,
            // aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            // enlargeCenterPage: true,
            // enlargeFactor: 0.3,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              homeController.currentCarouselIndex.value = index;
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ads.images!.asMap().entries.map((entry) {
              return Container(
                // edit
                // غير قياس
                width: 7,
                height: 7,
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // edit
                  // غير سماكة
                  border: homeController.currentCarouselIndex.value == entry.key
                      ? Border.all(
                          color: ThemeApp.Foundation_Main_main_100,
                          width: 1.5,
                        )
                      : Border.all(style: BorderStyle.none),
                  color: homeController.currentCarouselIndex.value == entry.key
                      ? ThemeApp.Foundation_Main_main_500
                      : ThemeApp.colorCirclesSliderAndStarAndDivider,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
