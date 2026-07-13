import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_ad_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';
import 'package:servixa/features/search_filter/presentation_layer/widgets/filtter_bottom_sheet_widget.dart';

// enum SingingCharacter { lafayette, jefferson }

class SearchScreen extends StatelessWidget {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  final AdsController adsController = Get.put(AdsController());
  final CategoryController categoryController = Get.put(CategoryController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        searchFilterController.adsSearchList.value =
            adsController.adsList.value;
        searchFilterController.adsSearchList.refresh();
        return true;
      },

      child: Scaffold(
        backgroundColor: ThemeApp.whiteBackground,
        appBar: AppBarWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: size.width * DimensApp.spaceHorizontalScreen,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppSearchTextFormFieldWidget(
                  onChanged: searchFilterController.onSearchChanged,
                  onPressed: () {
                    Get.bottomSheet(
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      FiltterBottomSheetWidget(),
                    );
                  },
                  onFieldSubmitted: (value) {
                    searchFilterController.filterSearch.value = value;
                    // searchFilterController.applyFilters();
                  },
                ),
              ),
              const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
              Obx(
                () => Text(
                  searchFilterController.isDisplayTitleSearchResults()
                      ? "Searched items".tr()
                      : "All Ads".tr(),
                  style: TypographyApp.title_top_home.copyWith(
                    color: ThemeApp.Foundation_Main_Color_900,
                  ),
                ),
              ),
              const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
              Center(
                child: Obx(() {
                  if (searchFilterController.isLoadingAdsFilter.value) {
                    // return Center(child: CircularProgressIndicator());
                    // return LoadingAnimationWidget(
                    //   message: "Loading ads...",
                    //   showLogo: true,
                    // );
                    return ShimmerCardList(
                      widthCard: 0.431,
                      heightCard: size.height,
                      itemCount: 6,
                    );
                  }
                  if (adsController.isLoading.value) {
                    // return Center(child: CircularProgressIndicator());
                    // return LoadingAnimationWidget(
                    //   message: "Loading ads...",
                    //   showLogo: true,
                    // );
                    return ShimmerCardList(
                      widthCard: 0.431,
                      heightCard: size.height,
                      itemCount: 6,
                    );
                  }
                  if (searchFilterController.adsSearchList.isEmpty) {
                    // return Text(
                    //   "No results found",
                    //   style: TypographyApp.Body_mid_Mid.copyWith(
                    //     color: ThemeApp.Foundation_Secendary_grey_300,
                    //   ),
                    // );
                    return AppNothingWidget(message: "No results found.".tr());
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchFilterController.adsSearchList.length,
                    itemBuilder: (context, indexAds) {
                      AdsModel ads =
                          searchFilterController.adsSearchList[indexAds];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child:
                            // AppCardAdsWidget(
                            //   ads: ads,
                            //   widthCard: 0.9139,
                            //   isGridView: false,
                            //   isSearchCard: true,
                            //   onTap: () {
                            //     Get.to(() => AdsDetailsScreen(adsId: ads.id));
                            //   },
                            // ),
                            OpenContainer(
                              transitionType:
                                  ContainerTransitionType.fadeThrough,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(33),
                                ),
                              ),
                              closedElevation: 4,
                              closedColor: Colors.white,
                              openElevation: 0,
                              openColor: Colors.transparent,
                              closedBuilder: (context, action) {
                                return AppCardAdsWidget(
                                  ads: ads,
                                  widthCard: 0.9139,
                                  isGridView: false,
                                  isSearchCard: true,
                                  // onTap: () {
                                  //   Get.to(
                                  //     () => AdsDetailsScreen(adsId: ads.id),
                                  //   );
                                  // },
                                );
                              },

                              openBuilder: (context, action) {
                                return AdsDetailsScreen(
                                  adsId: adsController.adsList[indexAds].id,
                                );
                              },
                            ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
