import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_ad_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';

class AllAdsOfCategoryScreen extends StatefulWidget {
  CategoryModel category;
  AllAdsOfCategoryScreen({super.key, required this.category});

  @override
  State<AllAdsOfCategoryScreen> createState() => _AllAdsOfCategoryScreenState();
}

class _AllAdsOfCategoryScreenState extends State<AllAdsOfCategoryScreen> {
  final RxInt crossAxisCount = 1.obs;
  final AdsController adsController = Get.put(AdsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      adsController.adsCategory.clear();
      adsController.getAds(categoryId: widget.category.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRichTextWidget(
              // firstText: "Ads in ",
              // secondText: widget.category.name,
              firstText: widget.category.name,
              secondText: " ads",
              typographyApp: TypographyApp.Title_larg_Mid,
              colorFirstText: ThemeApp.Foundation_Main_main_500,
              colorSecondText: ThemeApp.black,
            ),

            Obx(() {
              if (adsController.isLoading.value) {
                // return Center(child: CircularProgressIndicator());
                // return LoadingAnimationWidget(message: "Loading ads...", showLogo: true,);
                // return Expanded(child: ShimmerCardGridView(widthCard: 0.431, heightCard: 118));
                return Expanded(
                  child: ShimmerCardList(widthCard: 0.431, heightCard: 118),
                );
              }
              if (adsController.hasErrorLoadingAds.value) {
                return Expanded(
                  child: InternetConnectionErrorWidget(
                    onPressed: () =>
                        adsController.getAds(categoryId: widget.category.id),
                  ),
                );
              }
              if (adsController.adsCategory.isEmpty) {
                return Expanded(child: AppNothingWidget());
              }
              return Expanded(
                child: GridView.builder(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount.value,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: crossAxisCount.value == 1 ? 2.5 : 0.69,
                  ),
                  itemCount: adsController.adsCategory.length,
                  itemBuilder: (context, indexAds) {
                    return 
                    // AppCardAdsWidget(
                    //   ads: adsController.adsCategory[indexAds],
                    //   widthCard: 0.431,
                    //   isGridView: crossAxisCount.value == 2,
                    //   isSearchCard: true,
                    //   onTap: () {
                    //     Get.to(
                    //       () => AdsDetailsScreen(
                    //         adsId: adsController.adsCategory[indexAds].id,
                    //       ),
                    //     );
                    //   },
                    // );
                  
                     OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      closedElevation: 0,

                      closedBuilder: (context, action) {
                        return AppCardAdsWidget(
                      ads: adsController.adsCategory[indexAds],
                      widthCard: 0.431,
                      isGridView: crossAxisCount.value == 2,
                      isSearchCard: true,
                      // onTap: () {
                      //   Get.to(
                      //     () => AdsDetailsScreen(
                      //       adsId: adsController.adsCategory[indexAds].id,
                      //     ),
                      //   );
                      // },
                    );
                  
                      },

                      openBuilder: (context, action) {
                        return AdsDetailsScreen(adsId: adsController.adsCategory[indexAds].id,
                        );
                      },
                    );
            
                  },
                ),
              );
            }),
          ],
        ),
      ),
      // ),
    );
  }
}
