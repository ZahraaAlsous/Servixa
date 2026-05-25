import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/favorite_ad/business_layer/favorite_controller.dart';

class MyFavoriteScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(
        title: Text(
          "My Favorite",
          style: TypographyApp.Title_larg_Mid.copyWith(
            color: ThemeApp.Foundation_Main_main_500,
          ),
        ),
      ),
      body: Obx(() {
        if (favoriteController.isLoadingFavorite.value) {
          // return Center(child: CircularProgressIndicator());
          return LoadingAnimationWidget(
            message: "Loading ads...",
            showLogo: true,
          );
        }
        if (favoriteController.myFavoriteAdsList.isEmpty) {
          return Expanded(child: AppNothingWidget());
        }
        return Obx(
          () => GridView.builder(
            padding: EdgeInsetsGeometry.only(
              left: size.width * DimensApp.spaceHorizontalScreen,
              right: size.width * DimensApp.spaceHorizontalScreen,
              bottom: 60,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteController.myFavoriteAdsList.length,
            itemBuilder: (context, indexAd) {
              AdsModel ad = favoriteController.myFavoriteAdsList[indexAd];
              return AppCardAdsWidget(
                ads: ad,
                widthCard: 0.431,
                isGridView: true,
              );
            },
          ),
        );
      }),
    );
  }
}
