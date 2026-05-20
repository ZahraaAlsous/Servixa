import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/home/business_later/home_controller.dart';

class CircleSlidersWidget extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  CircleSlidersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: carouselImages.asMap().entries.map((entry) {
        children: homeController.sliders.asMap().entries.map((entry) {
          return Container(
            // edit
            // غير قياس
            width: 7,
            height: 7,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
    ) // edit
    ;
  }
}
