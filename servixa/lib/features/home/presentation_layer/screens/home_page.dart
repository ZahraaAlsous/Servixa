import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
// import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_ad_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_category_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/ads/presentation_layer/screens/view_all_ads_screen.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/presentation_layer/screens/all_ads_of_category_screen.dart';
import 'package:servixa/features/category/presentation_layer/screens/categories_screen.dart';
import 'package:servixa/features/category/presentation_layer/screens/sub_category_screen.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';
import 'package:servixa/common/widgets/app_title_section_widget.dart';
import 'package:servixa/features/home/presentation_layer/widgets/app_bar_home_widget.dart';
import 'package:servixa/features/home/presentation_layer/widgets/circle_sliders_widget.dart';
import 'package:servixa/features/home/presentation_layer/widgets/sliders_home_widget.dart';
import 'package:servixa/features/search_filter/presentation_layer/screens/search_screen.dart';
import 'package:animations/animations.dart';

class HomePage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final AdsController adsController = Get.put(AdsController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarHomeWidget(),
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // TextButton(onPressed: () => Get.to(()=> SliversDemoPage()), child: Text("sliver")),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: size.width * DimensApp.spaceHorizontalScreen,
              ),
              child: AppRichTextWidget(
                firstText: "titleHome1".tr(),
                secondText: "titleHome2".tr(),
                typographyApp: TypographyApp.title_top_home,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: DimensApp.spaceBetweenSection),
            Center(
              child: AppSearchTextFormFieldWidget(
                readOnly: true,
                onTap: () {
                  Get.to(() => SearchScreen());
                },
              ),
            ),
            const SizedBox(height: DimensApp.spaceBetweenSection),

            SlidersHomeWidget(),
            const SizedBox(height: 10),
            CircleSlidersWidget(),

            AppTitleSectionWidget(
              data: "Categories",
              onPressed: () {
                Get.to(() => CategoriesScreen());
              },
            ),
            //
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
            Obx(() {
              if (categoryController.isLoadingCategory.value) {
                // return Center(child: CircularProgressIndicator());
                // return LoadingAnimationWidget(
                //   message: "Loading categories...".tr(),
                // );
                return ShimmerCategoriesList(height: 84);
              }
              if (categoryController.hasErrorLoadingCategory.value) {
                return InternetConnectionErrorWidget(
                  onPressed: () {
                    categoryController.getCategories(
                      (e) {},
                      // AppSnackbar.showError
                    );
                  },
                );
              }
              return SizedBox(
                // height: size.height * 0.090,
                // height: 200,
                height: 84,
                child: ListView.builder(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, indexCategory) {
                    CategoryModel category =
                        categoryController.categories[indexCategory];
                    return AppCardCategoryWidget(
                      assetName: category.icon,
                      categoryName: category.name,
                      CategoryId: category.id,
                      margin: true,
                      onTap: () {
                        category.hasChildren
                            ? Get.to(
                                () => SubCategoryScreen(category: category),
                              )
                            : Get.to(
                                () =>
                                    AllAdsOfCategoryScreen(category: category),
                              );
                      },
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: DimensApp.spaceBetweenSection),

            AppTitleSectionWidget(
              data: "titleSectionHome1",
              onPressed: () {
                Get.to(() => ViewAllAdsScreen(title: "titleSectionHome1"));
              },
            ),
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
            Obx(() {
              if (adsController.isLoading.value) {
                // return Center(child: CircularProgressIndicator());
                // return LoadingAnimationWidget(message: "Loading ads...".tr());
                return ShimmerCardHorizontalList(
                  widthCard: size.width * 0.413,
                  heightCard: 236,
                );
              }

              if (adsController.hasErrorLoadingAds.value) {
                return InternetConnectionErrorWidget(
                  onPressed: () {
                    adsController.getAds();
                  },
                );
              }
              return SizedBox(
                // note
                // ليس نفس قياس التصميم
                height: 236,
                child: Obx(() {
                  return ListView.builder(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: adsController.adsList.length,
                    itemBuilder: (context, indexAds) {
                      AdsModel ads = adsController.adsList[indexAds];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child:
                            OpenContainer(
                              transitionType:
                                  ContainerTransitionType.fadeThrough,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              closedElevation: 0,

                              closedBuilder: (context, action) {
                                return AppCardAdsWidget(
                                  ads: adsController.adsList[indexAds],
                                  widthCard: 0.413,
                                  isGridView: true,
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
              );
            }),

            const SizedBox(height: DimensApp.spaceBetweenSection),

            AppTitleSectionWidget(
              data: "titleSectionHome2",
              onPressed: () {
                Get.to(() => ViewAllAdsScreen(title: "titleSectionHome2"));
              },
            ),
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

            Obx(() {
              if (adsController.isLoading.value) {
                // return Center(child: CircularProgressIndicator());
                // return LoadingAnimationWidget(message: "Loading ads...".tr());
                return ShimmerCardHorizontalList(
                  widthCard: size.width * 0.367,
                  heightCard: 236,
                );
              }
              if (adsController.hasErrorLoadingAds.value) {
                return InternetConnectionErrorWidget(
                  onPressed: () {
                    adsController.getAds();
                  },
                );
              }
              return SizedBox(
                // note
                // ليس نفس قياس التصميم
                height: 236,
                child: Obx(() {
                  return ListView.builder(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: adsController.adsList.length,
                    itemBuilder: (context, indexAds) {
                      AdsModel ads = adsController.adsList[indexAds];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),

                        child:
                            OpenContainer(
                              transitionType:
                                  ContainerTransitionType.fadeThrough,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              closedElevation: 0,

                              closedBuilder: (context, action) {
                                return AppCardAdsWidget(
                                  ads: ads,
                                  widthCard: 0.367,
                                  isGridView: true,
                                  // onTap: () {
                                  //   Get.to(AdsDetailsScreen(adsId: ads.id));
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
              );
            }),
            const SizedBox(height: DimensApp.spaceBetweenSection),

            AppTitleSectionWidget(
              data: "titleSectionHome3",
              onPressed: () {
                Get.to(() => ViewAllAdsScreen(title: "titleSectionHome3"));
              },
            ),
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

            Obx(() {
              if (adsController.isLoading.value) {
                // return Center(child: CircularProgressIndicator());
                // return LoadingAnimationWidget(message: "Loading ads...".tr());
                return ShimmerCardHorizontalList(
                  widthCard: size.width * 0.611,
                  heightCard: 236,
                );
              }
              if (adsController.hasErrorLoadingAds.value) {
                return InternetConnectionErrorWidget(
                  onPressed: () {
                    adsController.getAds();
                  },
                );
              }
              return SizedBox(
                // note
                // ليس نفس قياس التصميم
                height: 236,
                child: Obx(() {
                  return ListView.builder(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: adsController.adsList.length,
                    itemBuilder: (context, indexAds) {
                      AdsModel ads = adsController.adsList[indexAds];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child:
                            OpenContainer(
                              transitionType:
                                  ContainerTransitionType.fadeThrough,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              closedElevation: 0,

                              closedBuilder: (context, action) {
                                return AppCardAdsWidget(
                                  ads: ads,
                                  widthCard: 0.611,
                                  isGridView: true,
                                  // onTap: () {
                                  //   Get.to(
                                  //     () => AdsDetailsScreen(adsId: ads.id),
                                  //   );
                                  // },
                                );
                              },

                              openBuilder: (context, action) {
                                return AdsDetailsScreen(adsId: ads.id);
                              },
                            ),
                      );
                    },
                  );
                }),
              );
            }),
            const SizedBox(height: DimensApp.spaceBetweenSection),

            Obx(() {
              if (adsController.isLoading.value) {
                // return Center(child: CircularProgressIndicator());
                // return LoadingAnimationWidget(message: "Loading ads...".tr());
                return ShimmerCardGridView(widthCard: 0.413, shrinkWrap: true);
              }
              if (adsController.hasErrorLoadingAds.value) {
                return InternetConnectionErrorWidget(
                  onPressed: () {
                    adsController.getAds();
                  },
                );
              }
              return GridView.builder(
                padding: EdgeInsetsGeometry.only(
                  right: size.width * DimensApp.spaceHorizontalScreen,
                  left: size.width * DimensApp.spaceHorizontalScreen,
                  bottom: 63,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.7,
                ),
                itemCount: adsController.adsList.length,
                // itemCount: adsController.adsList.length + 1,
                itemBuilder: (context, indexAds) {
                  // if (indexAds == adsController.adsList.length) {
                  //   return _buildEndOfListIndicator(context);
                  // }
                  AdsModel ads = adsController.adsList[indexAds];
                  return
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    closedElevation: 0,

                    closedBuilder: (context, action) {
                      return AppCardAdsWidget(
                        ads: ads,
                        widthCard: 0.431,
                        isGridView: true,
                        // onTap: () {
                        //   Get.to(() => AdsDetailsScreen(adsId: ads.id));
                        // },
                      );
                    },

                    openBuilder: (context, action) {
                      return AdsDetailsScreen(
                        adsId: adsController.adsList[indexAds].id,
                      );
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
