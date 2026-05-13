import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/ads/data_layer/sourses/ad_service.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';

class AdsController extends GetxController {
  final AdService adService = AdService();
  RxBool showMore = false.obs;
  RxList<AdsModel> adsList = <AdsModel>[].obs;
  RxList<AdsModel> myAdsList = <AdsModel>[].obs;
  RxList<AdsModel> acceptedMyAdList = <AdsModel>[].obs;
  RxList<AdsModel> pendingMyAdList = <AdsModel>[].obs;
  RxList<AdsModel> rejectedMyAdList = <AdsModel>[].obs;
  Rx<AdsModel?> adsDetails = Rx<AdsModel?>(null);
  RxBool isLoading = false.obs;
  RxBool isLoadingMyAdd = false.obs;
  RxBool isSelectedPendingMyAd = false.obs;
  RxBool isSelectedAcceptedMyAd = true.obs;
  RxBool isSelectedRejectedMyAd = false.obs;

  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();

    // int? adId = Get.arguments;
    getAds();
    // if (adId != null) {
    // //   log("///////id${adId}");
    //   getAddDetailss(adId);
    // //   //  getAdsDetails(adId);
    // }
  }

  Future<void> getAds() async {
    try {
      isLoading.value = true;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Ads IN");

      List<AdsModel> ads = await adService.getAds();
      adsList.clear();
      adsList.addAll(ads);

      log("==============================Controller : Ads OK");
    } catch (e) {
      log("==============================Controller : Ads ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // void getAdsDetails(int AdsId) {
  //   adsDetails.value = adsList.firstWhere((item) => item.id == AdsId);
  // }

  Future<void> getAddDetailss(
    int adId,
    // void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isLoading.value = true;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Ad Details IN");

      adsDetails.value = await adService.getAdDetails(adId);
      log("==============================Controller : Ad Details OK");
    } catch (e) {
      log("==============================Controller : Ad Details ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      // onError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> getMyAds(
  //   void Function() onSuccess,
  //   void Function(String e) onError,
  // ) async {
  //   try {
  //     isLoadingMyAdd.value = true;
  //     log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : My Ads IN");

  //     List<AdsModel> myAds = await adService.getMyAds();
  //     myAdsList.clear();
  //     myAdsList.addAll(myAds);

  //     log("==============================Controller : My Ads OK");
  //   } catch (e) {
  //     log("==============================Controller : My Ads ERROR");
  //     log(
  //       "==============================Controller THE ERROR IS: " +
  //           e.toString(),
  //     );
  //     onError(e.toString());
  //   } finally {
  //     isLoadingMyAdd.value = false;
  //   }
  // }

  Future<void> acceptMyAds() async {
    acceptedMyAdList.value = await myAdsList
        .where((item) => item.status == "accepted")
        .toList();
  }

  Future<void> pendingMyAds() async {
    pendingMyAdList.value = await myAdsList
        .where((item) => item.status == "pending")
        .toList();
  }

  Future<void> rejectedMyAds() async {
    rejectedMyAdList.value = await myAdsList
        .where((item) => item.status == "rejected")
        .toList();
  }

  Future<void> getMyAds(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      int curenPage = 1;
      List<AdsModel> adsPage = [];
      List<AdsModel> allMyAd = [];
      do {
        log(
          ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : My Ads Page $curenPage IN",
        );
        curenPage == 1
            ? isLoadingMyAdd.value = true
            : isLoadingMyAdd.value = false;

        adsPage.clear();
        adsPage = await adService.getMyAds(page: curenPage);
        curenPage++;
        allMyAd.addAll(adsPage);
        log(
          "==============================Controller : My Ads Page $curenPage OK",
        );
      } while (adsPage.length == 15);
      myAdsList.clear();
      myAdsList.addAll(allMyAd);
      await acceptMyAds();
      await pendingMyAds();
      await rejectedMyAds();

      log("==============================Controller : My Ads OK");
    } catch (e) {
      log("==============================Controller : My Ads ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      onError(e.toString());
    } finally {
      isLoadingMyAdd.value = false;
    }
  }

  Future<void> deleteAd(
    int adId,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Delete Ad IN");

      bool isDeleted = await adService.deleteAd(adId);
      if (isDeleted) {
        myAdsList.removeWhere((ad) => ad.id == adId);
        acceptedMyAdList.removeWhere((ad) => ad.id == adId);
        pendingMyAdList.removeWhere((ad) => ad.id == adId);
        rejectedMyAdList.removeWhere((ad) => ad.id == adId);
        log("==============================Controller : Delete Ad OK");
        onSuccess();
      } else {
        log("==============================Controller : Delete Ad ERROR");
      }
    } catch (e) {
      log("==============================Controller : Delete Ad ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      onError(e.toString());
    }
  }
}
