import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/location%20user/business_layer/location_controller.dart';
import 'package:servixa/features/search_filter/presentation_layer/screens/search_screen.dart';

class ViewAllAdsScreen extends StatelessWidget {
  final String title;
  ViewAllAdsScreen({super.key, required this.title});
  AdsController adsController = Get.put(AdsController());
  final LocationController locationController = Get.find<LocationController>();
  final RxInt crossAxisCount = 1.obs;
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
            Obx(() {
              if (locationController.addressUserSelected.value != "") {
                return AppRichTextWidget(
                  // firstText: "Top Construction Services in",
                  firstText: title,
                  secondText: " in your location",
                  typographyApp: TypographyApp.Title_larg_Mid,
                  maxLines: 2,
                );
              }
              return Text(
                // "Top Construction Services in",
                title.tr(),
                style: TypographyApp.Title_larg_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_700,
                ),
              );
            }),
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: AppSearchTextFormFieldWidget(
                      widthTextForm: size.width * 0.809,
                      radio: 16,
                      readOnly: true,
                      onTap: () {
                        Get.to(() => SearchScreen());
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      crossAxisCount.value = crossAxisCount.value == 1 ? 2 : 1;
                    },
                    icon: SvgPicture.asset(
                      width: 32,
                      height: 32,
                      crossAxisCount.value == 2
                          ? IconApp.circumBoxList
                          : IconApp.mynauiGrid,
                    ),
                  ),
                ],
              );
            }),
            Expanded(
              child: Obx(() {
                return GridView.builder(
                  padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount.value,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: crossAxisCount.value == 1 ? 2.5 : 0.69,
                  ),
                  itemCount: adsController.adsList.length,
                  itemBuilder: (context, indexAds) {
                    return
                    OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      closedElevation: 0,

                      closedBuilder: (context, action) {
                        return AppCardAdsWidget(
                          ads: adsController.adsList[indexAds],
                          widthCard: 0.431,
                          isGridView: crossAxisCount.value == 2,
                          isViewAll: true,
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
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
