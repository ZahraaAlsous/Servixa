import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';

class AppBarMyAdsWidget extends StatelessWidget implements PreferredSizeWidget {
  final AdsController adsController = Get.put(AdsController());
  final double? toolbarHeight;

  AppBarMyAdsWidget({super.key, this.toolbarHeight});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBarWidget(
      toolbarHeight: toolbarHeight,
      title: Column(
        children: [
          Text(
            "My Ads".tr(),
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Main_main_500,
            ),
          ),
          Container(
            height: 48,
            width: size.width * 0.895,
            padding: const EdgeInsetsGeometry.all(2),
            decoration: BoxDecoration(
              color: ThemeApp.whiteBackground,
              borderRadius: BorderRadius.circular(21),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,

                      onTap: () {
                        // orderController.isSelectedMyOrders.value = false;
                        adsController.isSelectedAcceptedMyAd.value = true;
                        adsController.isSelectedPendingMyAd.value = false;
                        adsController.isSelectedRejectedMyAd.value = false;
                      },
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: adsController.isSelectedAcceptedMyAd.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                        ),
                        child: Text(
                          "Accepted".tr(),
                          style: TypographyApp.text_button_order.copyWith(
                            color: !adsController.isSelectedAcceptedMyAd.value
                                ? ThemeApp.Foundation_Main_main_500
                                : ThemeApp.whiteBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,

                      onTap: () {
                        adsController.isSelectedPendingMyAd.value = true;
                        adsController.isSelectedAcceptedMyAd.value = false;
                        adsController.isSelectedRejectedMyAd.value = false;
                        // adsc.isSelectedMyOrders.value = true;
                      },
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: adsController.isSelectedPendingMyAd.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                        ),
                        child: Text(
                          "Pending".tr(),
                          style: TypographyApp.text_button_order.copyWith(
                            color: !adsController.isSelectedPendingMyAd.value
                                ? ThemeApp.Foundation_Main_main_500
                                : ThemeApp.whiteBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Obx(
                    () => InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,

                      onTap: () {
                        adsController.isSelectedRejectedMyAd.value = true;
                        adsController.isSelectedAcceptedMyAd.value = false;
                        adsController.isSelectedPendingMyAd.value = false;
                        // adsc.isSelectedMyOrders.value = true;
                      },
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: adsController.isSelectedRejectedMyAd.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                        ),
                        child: Text(
                          "Rejected".tr(),
                          style: TypographyApp.text_button_order.copyWith(
                            color: !adsController.isSelectedRejectedMyAd.value
                                ? ThemeApp.Foundation_Main_main_500
                                : ThemeApp.whiteBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
