import 'package:animations/animations.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_ad_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';

class BottomSheetPortfolioWidget extends StatelessWidget {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  final AdsModel ad;
  BottomSheetPortfolioWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: ThemeApp.whiteBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconApp.business,
                  width: 25,
                  height: 25,
                  color: ThemeApp.Foundation_Main_main_300,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Portfolio".tr(),
                    style: TypographyApp.Title_larg_Mid.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    IconApp.cancel,
                    width: 32,
                    height: 32,
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // CircleAvatar(
                  //   radius: 40,
                  //   backgroundImage: AssetImage(ImageApp.profileImageRounded),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(50),
                    child:
                        // FadeInImage(
                        //   width: 80,
                        //   height: 80,
                        //   fit: BoxFit.cover,
                        //   placeholder: AssetImage(ImageApp.placeholder),
                        //   image: ad.user.image == null
                        //       ? AssetImage(ImageApp.profileImage)
                        //       : NetworkImage(ad.user.image!),
                        //   imageErrorBuilder: (context, error, stackTrace) {
                        //     return CircleAvatar(
                        //       radius: 37,
                        //       backgroundColor:
                        //           ThemeApp.Foundation_Secendary_grey_100,
                        //       child: const Icon(
                        //         Icons.broken_image,
                        //         size: 30,
                        //         color: Colors.grey,
                        //       ),
                        //     );
                        //   },
                        // ),
                        ad.user.image == null
                        ? Image(
                            image: AssetImage(ImageApp.profileImage),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: ad.user.image!,
                            placeholder: (context, url) => Image.asset(
                              ImageApp.placeholder,
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                            errorWidget: (context, url, error) {
                              return CircleAvatar(
                                radius: 37,
                                backgroundColor:
                                    ThemeApp.Foundation_Secendary_grey_100,
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

                  const SizedBox(height: 10),

                  Text(
                    ad.user.firstName + ad.user.lastName,
                    style: TypographyApp.Title_Mid_Mid.copyWith(
                      color: ThemeApp.black,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconApp.business, width: 16, height: 16),
                      const SizedBox(width: 5),

                      Text(
                        // "Qualified Plus+",
                        ad.businessAccount!.businessNameEnglish,
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // edit
                      // SvgPicture.network(
                      //   ad.businessAccount!.userType!.icon!.url,
                      // ),
                      Text(
                        ad.businessAccount!.userType!.name,
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Secendary_grey_300,
                        ),
                      ),
                    ],
                  ),

                  const Divider(
                    color: ThemeApp.Foundation_Secendary_grey_50,
                    thickness: 4,
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Information".tr(),
                          style: TypographyApp.Title_larg_Mid.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (ad.user.email != null)
                          _listTile(
                            title: "Email : ",
                            // trailing: ad.businessAccount!.approvedAt!,
                            trailing: ad.user.email!,
                            leading: IconApp.email,
                          ),
                        if (ad.user.phone != null)
                          _listTile(
                            title: "Phone : ",
                            // trailing: ad.businessAccount!.approvedAt!,
                            trailing: ad.user.phone!,
                            leading: IconApp.phone,
                          ),
                        _listTile(
                          title: "Date of joining : ",
                          // trailing: ad.businessAccount!.approvedAt!,
                          trailing: ad.businessAccount!
                              .getFormattedApprovedDate(),
                          leading: IconApp.clarityDateLine,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "My Ads".tr(),
                          style: TypographyApp.Title_larg_Mid.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Obx(() {
                          if (searchFilterController.isLoadingAdsFilter.value) {
                            // return Center(child: CircularProgressIndicator());
                            // return LoadingAnimationWidget(
                            //   message: "Loading ads...".tr(),
                            // );
                            return ShimmerCardHorizontalList(
                              widthCard: size.width * 0.367,
                              heightCard: 250,
                              itemCount: 6,
                            );
                          }
                          return SizedBox(
                            height: 250,
                            child: ListView.builder(
                              // itemCount: 5,
                              itemCount:
                                  searchFilterController.adsSearchList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indexAds) {
                                AdsModel ad = searchFilterController
                                    .adsSearchList[indexAds];
                                return Container(
                                  width: size.width * 0.367,
                                  margin: EdgeInsets.only(right: 12),
                                  child:
                                      // AppCardAdsWidget(
                                      //   ads: ad,
                                      //   widthCard: size.width * 0.367,
                                      //   isGridView: true,
                                      //   onTap: () {
                                      //     // Get.to(
                                      //     //   () => AdsDetailsScreen(adsId: ad.id),
                                      //     // );
                                      //     // Get.to(AdsDetailsScreen(), arguments: ads.id);
                                      //   },
                                      // ),
                                      OpenContainer(
                                        transitionType:
                                            ContainerTransitionType.fadeThrough,
                                        closedShape:
                                            const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                        closedElevation: 0,

                                        closedBuilder: (context, action) {
                                          return AppCardAdsWidget(
                                            ads: ad,
                                            widthCard: size.width * 0.367,
                                            isGridView: true,
                                            // onTap: () {
                                            //   // Get.to(
                                            //   //   () => AdsDetailsScreen(adsId: ad.id),
                                            //   // );
                                            //   // Get.to(AdsDetailsScreen(), arguments: ads.id);
                                            // },
                                          );
                                        },

                                        openBuilder: (context, action) {
                                          return AdsDetailsScreen(adsId: ad.id);
                                        },
                                      ),
                                );
                              },
                            ),
                          );
                        }),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile({
    required String title,
    required String trailing,
    required String leading,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(leading, width: 20, height: 20),
      title: Text(
        title.tr(),
        style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
      ),
      trailing: Text(
        trailing,
        style: TypographyApp.Body_mid_Mid.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_300,
        ),
      ),
    );
  }
}
