import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/data_layer/sourses/ad_service.dart';

class AdsController extends GetxController {
  final AdService adService = AdService();
  RxBool showMore = false.obs;
  RxList<AdsModel> adsList = <AdsModel>[].obs;
  RxList<AdsModel> adsCategory = <AdsModel>[].obs;
  RxList<AdsModel> myAdsList = <AdsModel>[].obs;
  RxList<AdsModel> acceptedMyAdList = <AdsModel>[].obs;
  RxList<AdsModel> pendingMyAdList = <AdsModel>[].obs;
  RxList<AdsModel> rejectedMyAdList = <AdsModel>[].obs;
  Rx<AdsModel?> adsDetails = Rx<AdsModel?>(null);
  RxBool isLoading = false.obs;
  RxBool hasErrorLoadingAds = false.obs;
  RxBool hasErrorLoadingDetails = false.obs;
  RxBool isLoadingMyAdd = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasErrorLoadingMyAds = false.obs;
  RxBool hasErrorLoadingMyAdsMore = false.obs;
  RxBool isDeleteNow = false.obs;
  RxBool isSelectedPendingMyAd = true.obs;
  RxBool isSelectedAcceptedMyAd = false.obs;
  RxBool isSelectedRejectedMyAd = false.obs;

  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();

    getAds();
  }

  Future<void> getAds({int? categoryId}) async {
    try {
      isLoading.value = true;
      hasErrorLoadingAds.value = false;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Ads IN");

      List<AdsModel> ads = await adService.getAds(categoryId: categoryId);
      categoryId == null ? adsList.clear() : adsCategory.clear();
      categoryId == null ? adsList.addAll(ads) : adsCategory.addAll(ads);

      log("==============================Controller : Ads OK");
    } catch (e) {
      hasErrorLoadingAds.value = true;
      log("==============================Controller : Ads ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAddDetailss(
    int adId,
    // void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isLoading.value = true;
      hasErrorLoadingDetails.value = false;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Ad Details IN");

      adsDetails.value = await adService.getAdDetails(adId);
      log("==============================Controller : Ad Details OK");
    } catch (e) {
      hasErrorLoadingDetails.value = true;
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
  Future<void> deleteAd(
    int adId,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Delete Ad IN");
      isDeleteNow.value = true;
      bool isDeleted = await adService.deleteAd(adId);
      if (isDeleted) {
        myAdsList.removeWhere((ad) => ad.id == adId);
        acceptedMyAdList.removeWhere((ad) => ad.id == adId);
        pendingMyAdList.removeWhere((ad) => ad.id == adId);
        rejectedMyAdList.removeWhere((ad) => ad.id == adId);
        adsList.removeWhere((ad) => ad.id == adId);
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
    } finally {
      isDeleteNow.value = false;
    }
  }

  Future<void> getMyAds(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isLoadingMyAdd.value = true;
      isLoadingMore.value = true;
      hasErrorLoadingMyAds.value = false;

      List<AdsModel> adsPage = await adService.getMyAds(page: 1);
      myAdsList.value = adsPage;
      await _filterAdsByStatus();

      log(
        "==============================Controller : My Ads Page 1 OK - ${adsPage.length} ads",
      );

      if (adsPage.length == 15) {
        _loadRemainingPages();
      }

      // onSuccess();
    } catch (e) {
      log("==============================Controller : My Ads Page 1 ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );

      hasErrorLoadingMyAds.value = true;
      isLoadingMore.value = false;

      onError(e.toString());
    } finally {
      isLoadingMyAdd.value = false;
    }
  }

  Future<void> _loadRemainingPages() async {
    int currentPage = 2;
    bool hasMore = true;
    hasErrorLoadingMyAdsMore.value = false;

    while (hasMore) {
      try {
        // isLoadingMyAdd.value = true;
        List<AdsModel> adsPage = await adService.getMyAds(page: currentPage);

        if (adsPage.isNotEmpty) {
          myAdsList.addAll(adsPage);
          await _filterAdsByStatus();

          log(
            "==============================Controller : My Ads Page $currentPage OK - ${adsPage.length} ads",
          );
          currentPage++;

          if (adsPage.length < 15) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }
      } catch (e) {
        log(
          "==============================Controller : My Ads page $currentPage ERROR",
        );
        log(
          "==============================Controller THE ERROR IS: " +
              e.toString(),
        );
        hasMore = false;
        hasErrorLoadingMyAdsMore.value = true;
      } finally {
        isLoadingMore.value = false;
      }
    }
  }

  Future<void> _filterAdsByStatus() async {
    acceptMyAds();
    pendingMyAds();
    rejectedMyAds();
  }

  Future<void> acceptMyAds() async {
    acceptedMyAdList.value = myAdsList
        .where((item) => item.status == "accepted")
        .toList();
  }

  Future<void> pendingMyAds() async {
    pendingMyAdList.value = myAdsList
        .where((item) => item.status == "pending")
        .toList();
  }

  Future<void> rejectedMyAds() async {
    rejectedMyAdList.value = myAdsList
        .where((item) => item.status == "rejected")
        .toList();
  }
}
