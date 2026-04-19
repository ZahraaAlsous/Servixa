import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/ads/presentation_layer/screens/view_all_ads_screen.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/presentation_layer/screens/categories_screen.dart';
import 'package:servixa/features/category/presentation_layer/screens/sub_category_screen.dart';
import 'package:servixa/features/home/business_later/home_controller.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/features/home/presentation_layer/widgets/home_card_category_widget.dart';
import 'package:servixa/common/widgets/app_title_section_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:servixa/features/profile/presentation_layer/screens/option_profile_screen.dart';
import 'package:servixa/features/search_filter/presentation_layer/screens/search_screen.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  TextEditingController searchController = TextEditingController();
  CategoryController categoryController = Get.put(CategoryController());
  HomeController homeController = Get.put(HomeController());
  AdsController adsController = Get.put(AdsController());
  HomePage({super.key});
  final List<String> carouselImages = [
    'assets/images/slider.png',
    'assets/images/slider.png',
    'assets/images/slider.png',
    'assets/images/slider.png',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar:
          authController.isLoggedIn.value &&
              authController.currentUser.value != null
          ? AppBarWidget(
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(OptionProfileScreen());
                    },
                    child: Container(
                      width: size.width * 0.109,
                      height: 48.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: authController.currentUser.value?.image != null
                              ? NetworkImage(
                                  authController.currentUser.value!.image!,
                                )
                              : AssetImage(ImageApp.profileImage),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          authController.currentUser.value!.name,
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Grey_grey_700,
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // qustion
                          // مو من مكتبة الألوان
                          // Icon(Icons.place_outlined, color: Color(0xff6D3FAE)),
                          SvgPicture.asset(
                            IconApp.place,
                            width: 16,
                            height: 16,
                            color: ThemeApp.colorIconProfileHomeScreen,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Riyadh – Malaz",
                            style: TypographyApp.Label_Mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Secendary_grey_600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Spacer(),
                  SvgPicture.asset(
                    IconApp.location,
                    width: 34,
                    height: 34,
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                ],
              ),
            )
          : AppBarWidget(
              title: Row(
                children: [
                  InkWell(
                    onTap: () => Get.to(OptionProfileScreen()),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ThemeApp.Foundation_Main_main_100,
                      child: Icon(
                        Icons.person_outline,
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, Guest".tr(),
                        style: TypographyApp.Title_Mid_Mid.copyWith(
                          color: ThemeApp.black,
                        ),
                      ),
                      Text(
                        "Login to enjoy all features".tr(),
                        style: TypographyApp.Label_Mid_Mid.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            AppRichTextWidget(
              firstText: "titleHome1".tr(),
              secondText: "titleHome2".tr(),
              typographyApp: TypographyApp.title_Sections,
              maxLines: 2,
            ),
            SizedBox(height: DimensApp.spaceBetweenSection),
            AppSearchTextFormFieldWidget(
              readOnly: true,
              onTap: () {
                Get.to(SearchScreen());
              },
            ),
            SizedBox(height: DimensApp.spaceBetweenSection),
            SizedBox(
              height: 145,
              child: CarouselSlider.builder(
                itemCount: carouselImages.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                      return Container(
                        width: size.width * 0.913,
                        height: 145,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(carouselImages[itemIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
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
            ),

            const SizedBox(height: 10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: carouselImages.asMap().entries.map((entry) {
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
                      border:
                          homeController.currentCarouselIndex.value == entry.key
                          ? Border.all(
                              color: ThemeApp.Foundation_Main_main_100,
                              width: 1.5,
                            )
                          : Border.all(style: BorderStyle.none),
                      color:
                          homeController.currentCarouselIndex.value == entry.key
                          ? ThemeApp.Foundation_Main_main_500
                          : ThemeApp.colorCirclesSliderAndStarAndDivider,
                    ),
                  );
                }).toList(),
              ),
            ), // edit
            // الاتنتقال إلى صفحة ال categories
            AppTitleSectionWidget(
              // data: "Categories".tr(),
              data: "Categories",
              onPressed: () {
                Get.to(CategoriesScreen());
              },
            ),
            //
            SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
            SizedBox(
              // height: size.height * 0.090,
              // height: 200,
              height: 84,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, indexCategory) {
                    CategoryModel category =
                        categoryController.categories[indexCategory];
                    return HomeCardCategoryWidget(
                      assetName: category.icon!,
                      categoryName: category.name,
                      CategoryId: category.id,
                      margin: true,
                      onTap: () {
                        Get.to(SubCategoryScreen(categoryId: category.id));
                      },
                    );
                  },
                );
              }),
            ),
            SizedBox(height: DimensApp.spaceBetweenSection),

            // edit
            // الاتنتقال إلى صفحة ال المطلوبة
            AppTitleSectionWidget(
              data: "titleSectionHome1",
              onPressed: () {
                Get.to(ViewAllAdsScreen());
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              // note
              // ليس نفس قياس التصميم
              height: 236,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: adsController.adsList.length,
                  itemBuilder: (context, indexAds) {
                    AdsModel ads = adsController.adsList[indexAds];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AppCardAdsWidget(
                        ads: ads,
                        widthCard: 0.413,
                        onTap: () {
                          Get.to(() => AdsDetailsScreen(adsId: ads.id));
                          // Get.to(AdsDetailsScreen(), arguments: ads.id);
                        },
                        isGridView: true,
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: DimensApp.spaceBetweenSection),

            // edit
            // الاتنتقال إلى صفحة ال المطلوبة
            AppTitleSectionWidget(
              data: "titleSectionHome2",
              onPressed: () {
                Get.to(ViewAllAdsScreen());
              },
            ),
            SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

            SizedBox(
              // note
              // ليس نفس قياس التصميم
              height: 236,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: adsController.adsList.length,
                  itemBuilder: (context, indexAds) {
                    AdsModel ads = adsController.adsList[indexAds];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),

                      child: AppCardAdsWidget(
                        ads: ads,
                        widthCard: 0.367,
                        isGridView: true,
                        onTap: () {
                          Get.to(AdsDetailsScreen(adsId: ads.id));
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: DimensApp.spaceBetweenSection),

            // edit
            // الاتنتقال إلى صفحة ال المطلوبة
            AppTitleSectionWidget(
              data: "titleSectionHome3",
              onPressed: () {
                Get.to(ViewAllAdsScreen());
              },
            ),
            SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

            SizedBox(
              // note
              // ليس نفس قياس التصميم
              height: 236,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: adsController.adsList.length,
                  itemBuilder: (context, indexAds) {
                    AdsModel ads = adsController.adsList[indexAds];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AppCardAdsWidget(
                        ads: adsController.adsList[indexAds],
                        widthCard: 0.611,
                        isGridView: true,
                        onTap: () {
                          Get.to(AdsDetailsScreen(adsId: ads.id));
                        },
                      ),
                    );
                  },
                );
              }),
            ),

            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                    onTap: () {
                      Get.to(AdsDetailsScreen(adsId: ads.id));
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
