import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/services/url_launcher_service%20.dart';
import 'package:servixa/features/home/business_later/home_controller.dart';

class SlidersHomeWidget extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  SlidersHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      if (homeController.isLoadingSlider.value) {
        // return Center(child: CircularProgressIndicator());
        // return LoadingAnimationWidget(showText: false);
        // return shimmerLoadingList(
        //   height: 145,
        //   widthCard: size.width * 0.913,
        //   heightCard: 145,
        //   margin: EdgeInsetsGeometry.symmetric(horizontal: 5),
        // );
        return SizedBox(
          height: 145,
          child: CarouselSlider.builder(
            // itemCount: carouselImages.length,
            itemCount: 2,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
                  return ShimmerLoadingWidget(width: size.width * 0.913);
                },
            options: CarouselOptions(
              height: 166,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                homeController.currentCarouselIndex.value = index;
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      }
      if (homeController.hasErrorLoadingSlider.value) {
        return InternetConnectionErrorWidget(
          onPressed: () {
            homeController.getImageSliders();
          },
        );
      }
      return SizedBox(
        height: 145,
        child: CarouselSlider.builder(
          // itemCount: carouselImages.length,
          itemCount: homeController.sliders.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return InkWell(
              onTap: () => UrlLauncherService.openUrl(
                Uri.parse(homeController.sliders[itemIndex].url),
              ),
              child:
                  // Container(
                  //   width: size.width * 0.913,
                  //   height: 145,
                  //   decoration: BoxDecoration(
                  //     color: ThemeApp.Foundation_Main_main_50,
                  //     borderRadius: BorderRadius.circular(12),
                  //     // image: DecorationImage(
                  //     //   // image: AssetImage(carouselImages[itemIndex]),
                  //     //   image: NetworkImage(
                  //     //     homeController.sliders[itemIndex].imageUrl.toString(),
                  //     //   ),
                  //     //   fit: BoxFit.cover,
                  //     // ),
                  //   ),
                  //   child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        // FadeInImage(
                        //   placeholder: AssetImage(ImageApp.placeholder),
                        //   image: NetworkImage(
                        //     homeController.sliders[itemIndex].imageUrl.toString(),
                        //   ),
                        //   fit: BoxFit.cover,
                        //   width: size.width * 0.913,
                        //   height: 145,
                        //   imageErrorBuilder: (context, error, stackTrace) {
                        //     return Container(
                        //       width: size.width * 0.913,
                        //       height: 145,
                        //       color: ThemeApp.Foundation_Secendary_grey_100,
                        //       child: const Icon(
                        //         Icons.broken_image,
                        //         size: 30,
                        //         color: Colors.grey,
                        //       ),
                        //     );
                        //   },
                        // ),
                        CachedNetworkImage(
                          placeholder: (context, url) => Image(
                            image: AssetImage(ImageApp.placeholder),
                            fit: BoxFit.cover,
                          ),
                          imageUrl: homeController.sliders[itemIndex].imageUrl
                              .toString(),
                          fit: BoxFit.cover,
                          width: size.width * 0.913,
                          height: 145,
                          errorWidget: (context, url, error) {
                            return Container(
                              width: size.width * 0.913,
                              height: 145,
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
              // ),
            );
          },
          options: CarouselOptions(
            height: 166,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              homeController.currentCarouselIndex.value = index;
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
      );
    });
  }
}
