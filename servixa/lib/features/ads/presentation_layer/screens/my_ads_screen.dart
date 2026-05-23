import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';

class MyAdsScreen extends StatefulWidget {
  MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  final AdsController adsController = Get.put(AdsController());

  @override
  void initState() {
    adsController.getMyAds(() {
      AppSnackbar.showSuccess("message");
    }, (e) => AppSnackbar.showError(e));
    // adsController.isSelectedAcceptedMyAd.value = false;
    // adsController.isSelectedPendingMyAd.value = true;
    // adsController.isSelectedRejectedMyAd.value = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      // appBar: AppBarWidget(title: Text("My Ads"),),
      appBar: AppBarWidget(
        toolbarHeight: 80,
        title: Column(
          children: [
            Text(
              "My Ads",
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
                            "Accepted",
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
                            "Pending",
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
                            "Rejected",
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
      ),

      body: Obx(() {
        if (adsController.isLoadingMyAdd.value &&
            ((adsController.isSelectedAcceptedMyAd.value &&
                    adsController.acceptedMyAdList.isEmpty) ||
                (adsController.isSelectedPendingMyAd.value &&
                    adsController.pendingMyAdList.isEmpty) ||
                (adsController.isSelectedRejectedMyAd.value &&
                    adsController.rejectedMyAdList.isEmpty))) {
          return Center(child: CircularProgressIndicator());
        }
        List<AdsModel> myAdsListFilter =
            adsController.isSelectedAcceptedMyAd.value
            ? adsController.acceptedMyAdList
            : (adsController.isSelectedPendingMyAd.value
                  ? adsController.pendingMyAdList
                  : adsController.rejectedMyAdList);
        return GridView.builder(
          padding: EdgeInsetsGeometry.only(
            left: size.width * DimensApp.spaceHorizontalScreen,
            right: size.width * DimensApp.spaceHorizontalScreen,
            bottom: 60,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: myAdsListFilter.length,
          itemBuilder: (context, indexAds) {
            AdsModel ads = myAdsListFilter[indexAds];
            return AppCardAdsWidget(
              ads: ads,
              widthCard: 0.431,
              isGridView: true,
              isMyAdd: true,
              onTap: () {
                Get.to(AdsDetailsScreen(adsId: ads.id));
              },
            );
          },
        );
      }),
    );
  }
}
