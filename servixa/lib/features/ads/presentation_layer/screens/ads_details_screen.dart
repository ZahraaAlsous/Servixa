import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_dialogs.dart';
import 'package:servixa/common/widgets/favoite_widget.dart';
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_ad_details_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/super_ads_screen.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/details_bottom_navigation_bar_widget.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/rate_section.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/review_section.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/slider_ad_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/bottom_sheet_add_order_widget.dart';
import 'package:servixa/features/rate/business_later/rate_controller.dart';
import 'package:servixa/features/rate/presentation_layer/widgets/bottom_sheet_review_widget.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/location_section.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/question_dynamic_section.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/space_between_section_widget.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/favorite_ad/business_layer/favorite_controller.dart';
import 'package:servixa/features/home/business_later/home_controller.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:readmore/readmore.dart';
import 'package:servixa/common/widgets/app_title_section_widget.dart';
import 'package:servixa/features/report%20an%20ad/presentation_layer/widgets/bottom_sheet_report_widget.dart';
import 'package:share_plus/share_plus.dart';

class AdsDetailsScreen extends StatefulWidget {
  int adsId;
  AdsDetailsScreen({super.key, required this.adsId});

  @override
  State<AdsDetailsScreen> createState() => _AdsDetailsScreenState();
}

class _AdsDetailsScreenState extends State<AdsDetailsScreen> {
  AdsController adsController = Get.put(AdsController());
  HomeController homeController = Get.put(HomeController());
  FavoriteController favoriteController = Get.put(FavoriteController());
  final storage = FlutterSecureStorage();
  final AuthController authController = Get.put(AuthController());
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  final AddAdsController addAdsController = Get.put(AddAdsController());
  final RateController rateController = Get.put(RateController());
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      adsController.getAddDetailss(widget.adsId, (e) {
        AppSnackbar.showError(e);
      });
      rateController.getRateReview(widget.adsId, (e) {
        AppSnackbar.showError(e);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size.width;
    final widthScreen = Get.width;
    return Obx(() {
      if (adsController.isLoading.value) {
        // return Scaffold(body: const Center(child: CircularProgressIndicator()));
        // return Scaffold(
        //   body: LoadingAnimationWidget(
        //     message: "Loading ad details...".tr(),
        //     showLogo: true,
        //   ),
        // );
        return ShimmerAdDetailsWidget();
      }

      if (adsController.hasErrorLoadingDetails.value) {
        return Scaffold(
          body: InternetConnectionErrorWidget(
            onPressed: () {
              adsController.getAddDetailss(widget.adsId, (e) {});
            },
          ),
        );
      }

      if (adsController.adsDetails.value == null) {
        // return Scaffold(body: const Center(child: Text("No data available")));
        return Scaffold(body: AppNothingWidget());
      }
      AdsModel ads = adsController.adsDetails.value!;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            if (ads.status == "accepted")
              IconButton(
                onPressed: () {
                  if (!authController.isLoggedIn.value ||
                      authController.currentUser.value == null) {
                    AppSnackbar.showAlert(
                      "Please login first to report this ad",
                    );
                  } else if (ads.user.id ==
                      authController.currentUser.value!.id) {
                    AppSnackbar.showAlert("You cannot report your own ad");
                  } else {
                    Get.bottomSheet(
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      BottomSheetReportWidget(adsId: ads.id),
                    );
                  }
                },
                icon: SvgPicture.asset(
                  IconApp.report,
                  width: 24,
                  height: 24,
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),

            IconButton(
              onPressed: () {
                _shareAds();
                log("share");
              },
              icon: SvgPicture.asset(
                IconApp.share,
                width: 24,
                height: 24,
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
          ],
        ),

        body:
            // if (adsController.adsDetails.value == null) {
            // return
            // Scaffold(
            // body:
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ads.images.isNotEmpty) SliderAdWidget(ads: ads),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      // horizontal: size.width * DimensApp.spaceHorizontalScreen,
                      horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextWidget(
                                  // firstText: ads.price.toString() + ads.typeCoin + "\,",
                                  firstText:
                                      ads.price.toString() +
                                      " " +
                                      ads.typeCoin +
                                      "\, ",
                                  secondText: ads.typeService,
                                  typographyApp: TypographyApp.Title_larg_Mid,
                                ),
                                Text(
                                  ads.title,
                                  style:
                                      TypographyApp.Headline_small_Mid.copyWith(
                                        color: ThemeApp.black,
                                      ),
                                ),
                              ],
                            ),
                            Spacer(),

                            // IconButton(
                            //   onPressed: authController.isLoggedIn.value
                            //       ? () {
                            //           // adsController.favorite(ads.id);
                            //           // favoriteController.addToFavorite(ads.id, (e) {
                            //           //   AppSnackbar.showError(e);
                            //           // });
                            //           // favoriteController.favoriteAdDetails(ads.id);
                            //           favoriteController.addToFavorite(ads.id, (
                            //             e,
                            //           ) {
                            //             AppSnackbar.showError(e);
                            //           });
                            //         }
                            //       : () {
                            //           AppSnackbar.showAlert(
                            //             "You must be logged in".tr(),
                            //           );
                            //         },
                            //   icon: Obx(() {
                            //     final isFavorite =
                            //         adsController.adsDetails.value?.favorite ??
                            //         false;
                            //     return SvgPicture.asset(
                            //       width: 20,
                            //       height: 20,
                            //       isFavorite
                            //           ? IconApp.favorite
                            //           : IconApp.favoriteBorder,
                            //       color: isFavorite
                            //           ? ThemeApp.Foundation_Main_main_400
                            //           : ThemeApp.black,
                            //     );
                            //   }),
                            // ),
                            Obx(() {
                              if (favoriteController.isMakeFavorite[ads.id] ==
                                  true) {
                                return const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              }
                              return FavoriteAnimatedButton(
                                isFavorite: ads.favorite,
                                onTap: authController.isLoggedIn.value
                                    ? () {
                                        favoriteController.addToFavorite(
                                          ads.id,
                                          (e) {
                                            AppSnackbar.showError(e);
                                          },
                                        );
                                      }
                                    : () {
                                        AppSnackbar.showAlert(
                                          "You must be logged in",
                                        );
                                      },
                              );
                            }),
                          ],
                        ),

                        Row(
                          children: [
                            SvgPicture.asset(
                              IconApp.place,
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
                            // edit
                            if (ads.place != null)
                              Text(
                                // "742 Evergreen Terrace, Springfield",
                                ads.place!,
                                style: TypographyApp.Body_mid_Regular.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_300,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SpaceBetweenSectionWidget(),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      // horizontal: size.width * DimensApp.spaceHorizontalScreen,
                      horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description".tr(),
                          style: TypographyApp.Title_larg_Mid.copyWith(
                            color: ThemeApp.Foundation_Main_Color_900,
                          ),
                        ),

                        ReadMoreText(
                          ads.dictation!,
                          // "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_300,
                          ),
                          // isCollapsed: ,
                          // postDataText: "...",
                          trimMode: TrimMode.Length,
                          // trimLines: 5,
                          trimLength: 200,
                          colorClickableText: ThemeApp.Foundation_Main_main_500,
                          trimCollapsedText: 'More...',
                          trimExpandedText: ' Less',
                          moreStyle: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          lessStyle: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          // locale: ,
                          // textScaler: ,
                          delimiter: " ",
                          // annotations: [],
                          // isExpandable: ,
                        ),
                      ],
                    ),
                  ),
                  const SpaceBetweenSectionWidget(),
                  if (ads.categoryQuestionAnswer != null &&
                      ads.categoryQuestionAnswer!.isNotEmpty)
                    QuestionDynamicSection(ads: ads),

                  if (ads.categoryQuestionAnswer != null &&
                      ads.categoryQuestionAnswer!.isNotEmpty)
                    const SpaceBetweenSectionWidget(),
                  if (ads.lat != null && ads.lng != null)
                    LocationSection(ads: ads),
                  const SpaceBetweenSectionWidget(),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      // horizontal: size.width * DimensApp.spaceHorizontalScreen,
                      horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
                      vertical: 5,
                    ),
                    child: Container(
                      // width: size.width * 0.9348,
                      width: widthScreen * 0.9348,
                      height: 51,
                      alignment: AlignmentGeometry.center,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          color: ThemeApp.Foundation_Main_main_300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconApp.reviewsRounded,
                            width: 25,
                            height: 25,
                            color: ThemeApp.Foundation_Main_main_300,
                          ),
                          Text(
                            " Rate this Ad".tr(),
                            style: TypographyApp.Title_larg_Mid,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SpaceBetweenSectionWidget(),
                  RateSection(),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
                  //     vertical: 5,
                  //   ),
                  //   child:
                  AppTitleSectionWidget(
                    data: "Top Reviews".tr(),
                    typographyAppButton: TypographyApp.Body_mid_Mid,
                    typographyAppTitle: TypographyApp.Title_larg_Mid,
                    // edit
                    // شو لبصفحة يلي بروح عليها
                    onPressed: () {},
                  ),
                  // ),
                  ReviewSection(),
                ],
              ),
            ),
        bottomNavigationBar:
            authController.currentUser.value != null &&
                ads.user.id == authController.currentUser.value!.id
            ? Obx(() {
                if (categoryController.isLoadingCategoryQuestions.value) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 10,
                    ),
                    child: LoadingAnimationWidget(
                      message: "Wait please...".tr(),
                    ),
                  );
                }
                if (adsController.isDeleteNow.value) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 10,
                    ),
                    child: LoadingAnimationWidget(
                      message: "Wait please...".tr(),
                      loaderColor: ThemeApp.Foundation_Statue_Red,
                    ),
                  );
                }
                return DetailsBottomNavigationBarWidget(
                  textButtonOutBorder: " Edit",

                  iconButtonOutBorder: IconApp.edit,
                  textButtonElevetedBorder: " Delete",
                  iconButtonElevetedBorder: IconApp.delete,
                  onPressedButtonOutBorder: () async {
                    businessAccountController.getBusinessAccountApproved();
                    await addAdsController.initialFailedEditAd(ads);
                    Get.to(SuperAdsScreen());
                  },
                  onPressedButtonElevetedBorder: () {
                    //   adsController.deleteAd(ads.id, () {
                    //     Get.back();
                    //     AppSnackbar.showSuccess("Ad removed successfully");
                    //   }, (e) => AppSnackbar.showError(e));
                    AppDialogs.showConfirmation(
                      title: "Confirm deletion",
                      message: "Are you sure you want to delete this ad?",
                      onConfirm: () {
                        adsController.deleteAd(ads.id, () {
                          Get.back();
                          AppSnackbar.showSuccess("Ad removed successfully");
                        }, (e) => AppSnackbar.showError(e));
                      },
                    );
                  },
                );
              })
            : DetailsBottomNavigationBarWidget(
                // textButtonOutBorder: "Chat",
                textButtonOutBorder: "Order",
                // iconButtonOutBorder: IconApp.messages,
                iconButtonOutBorder: IconApp.orders,
                textButtonElevetedBorder: " Make An Offer",
                iconButtonElevetedBorder: IconApp.badgePercent,
                onPressedButtonElevetedBorder: () {
                  if (authController.currentUser.value == null) {
                    AppSnackbar.showAlert(
                      "You must have an account and log in to the app through it in order to create an review.",
                    );
                  } else if (!authController
                      .currentUser
                      .value!
                      .hasBusinessAccount!) {
                    AppSnackbar.showAlert(
                      "You must have a business account and it must be accepted in order to create an review.",
                    );
                  } else {
                    Get.bottomSheet(
                      isDismissible: true,
                      enableDrag: true,
                      BottomSheetReviewWidget(adId: ads.id),
                    );
                  }
                },
                onPressedButtonOutBorder: () {
                  if (authController.currentUser.value == null) {
                    AppSnackbar.showAlert(
                      "You must have an account and log in to the app through it in order to create an order.",
                    );
                  } else if (!authController
                      .currentUser
                      .value!
                      .hasBusinessAccount!) {
                    AppSnackbar.showAlert(
                      "You must have a business account and it must be accepted in order to create an order.",
                    );
                  } else {
                    businessAccountController.getBusinessAccountApproved();
                    Get.bottomSheet(
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      BottomSheetAddOrderWidget(adId: ads.id),
                    );
                  }
                },
              ),
      );
    });
  }

  Future<void> _shareAds() async {
    try {
      String currentLang =
          EasyLocalization.of(
            WidgetsBinding.instance.focusManager.primaryFocus?.context ??
                Colors.transparent as BuildContext,
          )?.locale.languageCode ??
          "en";
      final ads = adsController.adsDetails.value!;

      String shareContent = currentLang == "ar"
          ? '''
🏠 *شارك إعلانًا من Servixa*
═══════════════════════

📌 *${ads.title}*
💰 *السعر:* ${ads.price} ${ads.typeCoin}
📍 *الموقع:* ${ads.place ?? 'غير محدد'}
📋 *النوع:* ${ads.typeService}

📝 *الوصف:* ${ads.dictation?.substring(0, ads.dictation!.length > 100 ? 100 : ads.dictation!.length)}${ads.dictation != null && ads.dictation!.length > 100 ? '...' : ''}

⭐ *التقييم:* ${rateController.ratesReview.value!.statistics.averageRating}/5
══════════════════════
🔗 *رابط عرض الإعلان:* https://servixa.com/ads/${ads.id}

📱 حمّل تطبيق Servixa
https://play.google.com/store/apps/details?id=com.servixa'''
          : '''
🏠 *Share ad from Servixa*
══════════════════════

📌 *${ads.title}*
💰 *Price:* ${ads.price} ${ads.typeCoin}
📍 *Location:* ${ads.place ?? 'Not specified'}
📋 *Type:* ${ads.typeService}

📝 *Description:* ${ads.dictation?.substring(0, ads.dictation!.length > 100 ? 100 : ads.dictation!.length)}${ads.dictation != null && ads.dictation!.length > 100 ? '...' : ''}

⭐ *Rate:* ${rateController.ratesReview.value!.statistics.averageRating}/5
══════════════════════
🔗 *View Ad Link:* https://servixa.com/ads/${ads.id} 

📱 Download the Servixa app 
https://play.google.com/store/apps/details?id=com.servixa''';

      // 2. التحقق من وجود صور للإعلان ومشاركتها
      if (ads.image != null && ads.image.isNotEmpty) {
        // final imageUrl = ads.images[0].url; // مسار رابط الصورة من الـ Model
        final imageUrl = ads.image; // مسار رابط الصورة من الـ Model

        // الحصول على مسار مجلد الكاش المؤقت بالجهاز
        final tempDir = await getTemporaryDirectory();
        final savePath = '${tempDir.path}/shared_image.png';

        // استخدام Dio لتحميل الصورة وحفظها مباشرة كملف
        final dio = Dio();
        await dio.download(imageUrl, savePath);

        await Share.shareXFiles(
          [XFile(savePath)],
          text: shareContent,
          subject: 'Share ad: ${ads.title}',
        );
      } else {
        await Share.share(shareContent, subject: 'Share ad: ${ads.title}');
      }

      log("Share Done with Dio");
    } catch (e) {
      log("Error in share: $e");
      AppSnackbar.showError("Could not share image: $e");
    }
  }
}
