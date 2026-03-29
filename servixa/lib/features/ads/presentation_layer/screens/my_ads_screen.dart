import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';

class MyAdsScreen extends StatelessWidget {
  final AdsController adsController = Get.put(AdsController());
  MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: Obx(() {
        return GridView.builder(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: size.width * DimensApp.spaceHorizontalScreen,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: adsController.adsList.length,
          itemBuilder: (context, indexAds) {
            AdsModel ads = adsController.adsList[indexAds];
            return AppCardAdsWidget(
              ads: ads,
              widthCard: 0.431,
              isGridView: true,
              isMyAdd: true,
              onTap: () {
                Get.to(AdsDetailsScreen(adsId: ads.id));
              },
            );
          },
        );
      }),
    );
  }
}
