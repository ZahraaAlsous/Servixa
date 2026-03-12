import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/card_ads_widget.dart';

class ViewAllAdsScreen extends StatelessWidget {
  ViewAllAdsScreen({super.key});
  AdsController adsController = Get.put(AdsController());
  final RxInt crossAxisCount = 1.obs;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: 
      AppBarWidget(),
      // AppBar(
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [ThemeApp.linearBackground, ThemeApp.whiteBackground],
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Construction Services in",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.Foundation_Secendary_grey_700,
              ),
            ),
            Text(
              "your location",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
            SizedBox(
              height: DimensApp.spaceBetweenTitleAndDetails,
            ),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: AppSearchTextFormFieldWidget(
                      widthTextForm: size.width * 0.809,
                      radio: 16,
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
                  padding: EdgeInsetsGeometry.symmetric(vertical: 10),
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
                    return CardAdsWidget(
                      ads: adsController.adsList[indexAds],
                      widthCard: 0.431,
                      isGridView: crossAxisCount.value == 2,
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
