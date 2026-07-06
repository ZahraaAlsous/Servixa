import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_ad_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/screens/ads_details_screen.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/app_bar_my_ads_widget.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

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
      appBar: AppBarMyAdsWidget(toolbarHeight: 80),
      body: Obx(() {
        // if (adsController.isLoadingMyAdd.value &&
        //     ((adsController.isSelectedAcceptedMyAd.value &&
        //             adsController.acceptedMyAdList.isEmpty) ||
        //         (adsController.isSelectedPendingMyAd.value &&
        //             adsController.pendingMyAdList.isEmpty) ||
        //         (adsController.isSelectedRejectedMyAd.value &&
        //             adsController.rejectedMyAdList.isEmpty))) {
        if (adsController.isLoadingMyAdd.value ||
            ((adsController.isSelectedAcceptedMyAd.value &&
                    adsController.acceptedMyAdList.isEmpty &&
                    adsController.isLoadingMore.value) ||
                (adsController.isSelectedPendingMyAd.value &&
                    adsController.pendingMyAdList.isEmpty &&
                    adsController.isLoadingMore.value) ||
                (adsController.isSelectedRejectedMyAd.value &&
                    adsController.rejectedMyAdList.isEmpty &&
                    adsController.isLoadingMore.value))) {
          // return Center(child: CircularProgressIndicataor());
          // return LoadingAnimationWidget(
          //   message: "Loading ads...".tr(),
          //   showLogo: true,
          // );
          return ShimmerCardGridView(widthCard: 0.34, shrinkWrap: false);
        }
        // if ((adsController.isLoadingMyAdd.value && adsController.hasErrorLoadingMyAds.value) ||(adsController.isSelectedAcceptedMyAd.value &&
        //         adsController.acceptedMyAdList.isEmpty &&
        //         adsController.isLoadingMore.value) ||
        //     (adsController.isSelectedPendingMyAd.value &&
        //         adsController.pendingMyAdList.isEmpty &&
        //         adsController.isLoadingMore.value) ||
        //     (adsController.isSelectedRejectedMyAd.value &&
        //         adsController.rejectedMyAdList.isEmpty &&
        //         adsController.isLoadingMore.value)) {
        if (adsController.hasErrorLoadingMyAds.value ||
            (adsController.isSelectedAcceptedMyAd.value &&
                adsController.acceptedMyAdList.isEmpty &&
                adsController.hasErrorLoadingMyAdsMore.value) ||
            (adsController.isSelectedPendingMyAd.value &&
                adsController.pendingMyAdList.isEmpty &&
                adsController.hasErrorLoadingMyAdsMore.value) ||
            (adsController.isSelectedRejectedMyAd.value &&
                adsController.rejectedMyAdList.isEmpty &&
                adsController.hasErrorLoadingMyAdsMore.value)) {
          return InternetConnectionErrorWidget(
            onPressed: () => adsController.getMyAds(() {}, (e) {}),
          );
        }
        if (adsController.isSelectedAcceptedMyAd.value &&
            adsController.acceptedMyAdList.isEmpty) {
          return AppNothingWidget();
        }
        if (adsController.isSelectedPendingMyAd.value &&
            adsController.pendingMyAdList.isEmpty) {
          return AppNothingWidget();
        }
        if (adsController.isSelectedRejectedMyAd.value &&
            adsController.rejectedMyAdList.isEmpty) {
          return AppNothingWidget();
        }
        List<AdsModel> myAdsListFilter =
            adsController.isSelectedAcceptedMyAd.value
            ? adsController.acceptedMyAdList
            : (adsController.isSelectedPendingMyAd.value
                  ? adsController.pendingMyAdList
                  : adsController.rejectedMyAdList);
        return GridView.builder(
          physics: const ClampingScrollPhysics(),
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
            return
            // AppCardAdsWidget(
            //   ads: ads,
            //   widthCard: 0.431,
            //   isGridView: true,
            //   isMyAdd: true,
            //   onTap: () {
            //     Get.to(() => AdsDetailsScreen(adsId: ads.id));
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
                  ads: ads,
                  widthCard: 0.431,
                  isGridView: true,
                  isMyAdd: true,
                  // onTap: () {
                  //   Get.to(() => AdsDetailsScreen(adsId: ads.id));
                  // },
                );
              },

              openBuilder: (context, action) {
                return AdsDetailsScreen(adsId: ads.id);
              },
            );
          },
        );
      }),
    );
  }
}
