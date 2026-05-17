import 'dart:developer';

import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/favorite_ad/data_layer/sourses/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService favoriteService = FavoriteService();
  final AdsController adsController = Get.put(AdsController());
  RxBool isLoadingFavorite = false.obs;
  RxList<AdsModel> myFavoriteAdsList = <AdsModel>[].obs;

  bool isAdCurrentlyFavorite(int adId) {
    return myFavoriteAdsList.any((item) => item.id == adId);
  }

  void changeFavoriteAd(int adId) {
    final bool isCurrentlyFavorite = isAdCurrentlyFavorite(adId);
    final bool newFavoriteStatus = !isCurrentlyFavorite;

    _updateFavoriteStatusInAllLists(adId, newFavoriteStatus);

    if (isCurrentlyFavorite) {
      myFavoriteAdsList.removeWhere((item) => item.id == adId);
    } else {
      final adFromList =
          adsController.adsList.firstWhereOrNull((item) => item.id == adId) ??
          adsController.myAdsList.firstWhereOrNull((item) => item.id == adId) ??
          adsController.acceptedMyAdList.firstWhereOrNull(
            (item) => item.id == adId,
          ) ??
          adsController.pendingMyAdList.firstWhereOrNull(
            (item) => item.id == adId,
          ) ??
          adsController.rejectedMyAdList.firstWhereOrNull(
            (item) => item.id == adId,
          );

      if (adFromList != null) {
        adFromList.favorite = true;
        myFavoriteAdsList.add(adFromList);
      }
    }

    myFavoriteAdsList.refresh();
    adsController.adsList.refresh();
    adsController.myAdsList.refresh();
    adsController.acceptedMyAdList.refresh();
    adsController.pendingMyAdList.refresh();
    adsController.rejectedMyAdList.refresh();

    if (adsController.adsDetails.value?.id == adId) {
      adsController.adsDetails.refresh();
    }
  }

  Future<bool> addToFavorite(int adId, void Function(String e) onError) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: AddToFavorite IN");

      bool isDone = await favoriteService.addToFavorite(adId: adId);

      if (isDone) {
        log("==============================Controller: AddToFavorite OK");
        changeFavoriteAd(adId);
        return true;
      } else {
        log("==============================Controller: AddToFavorite FAILED");
        return false;
      }
    } catch (e) {
      log("==============================Controller: AddToFavorite ERROR");
      log("Error: $e");
      onError(e.toString());
      return false;
    }
  }

  void _updateFavoriteStatusInAllLists(int adId, bool newFavoriteStatus) {
    final index = adsController.adsList.indexWhere((item) => item.id == adId);
    if (index != -1) {
      adsController.adsList[index].favorite = newFavoriteStatus;
    }

    final indexInMyAds = adsController.myAdsList.indexWhere(
      (item) => item.id == adId,
    );
    if (indexInMyAds != -1) {
      adsController.myAdsList[indexInMyAds].favorite = newFavoriteStatus;
    }

    final indexInAccepted = adsController.acceptedMyAdList.indexWhere(
      (item) => item.id == adId,
    );
    if (indexInAccepted != -1) {
      adsController.acceptedMyAdList[indexInAccepted].favorite =
          newFavoriteStatus;
    }

    final indexInPending = adsController.pendingMyAdList.indexWhere(
      (item) => item.id == adId,
    );
    if (indexInPending != -1) {
      adsController.pendingMyAdList[indexInPending].favorite =
          newFavoriteStatus;
    }

    final indexInRejected = adsController.rejectedMyAdList.indexWhere(
      (item) => item.id == adId,
    );
    if (indexInRejected != -1) {
      adsController.rejectedMyAdList[indexInRejected].favorite =
          newFavoriteStatus;
    }

    if (adsController.adsDetails.value?.id == adId) {
      adsController.adsDetails.value!.favorite = newFavoriteStatus;
    }
  }

  //   Future<bool> addToFavorite(int adId, void Function(String e) onError) async {
  //     try {
  //       log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: AddToFavorite IN");
  //       bool isDone = await favoriteService.addToFavorite(adId: adId);
  //       if (isDone) {
  //         log("==============================Controller: AddToFavorite OK");
  //         final index = adsController.adsList.indexWhere(
  //           (item) => item.id == adId,
  //         );
  //         final index2 = myFavoriteAdsList.indexWhere((item) => item.id == adId);
  //         final indexInMyAdList = adsController.myAdsList.indexWhere(
  //           (item) => item.id == adId,
  //         );

  // // true
  //         if (index2 != -1) {
  //           myFavoriteAdsList.removeWhere((item) => item.id == adId);
  //           myFavoriteAdsList.refresh();
  //         }
  //         if (index != -1) {
  //           adsController.adsList[index].favorite = index2 != -1 ? false : true;
  //           //     !adsController.adsList[index].favorite;
  //           // adsController.adsList[index].favorite ? false : true;
  //           adsController.adsList.refresh();
  //         }

  //         if (adsController.adsDetails.value?.id == adId) {
  //           // adsController.adsDetails.value?.favorite = true;
  //           // adsController.adsDetails.value!.favorite ? false : true;
  //           adsController.adsDetails.value!.favorite = index2 != -1
  //               ? false
  //               : true;
  //         //   if (indexInMyAdList != -1) {
  //         //     adsController.myAdsList[indexInMyAdList].favorite = index2 != -1
  //         //         ? false
  //         //         : true;
  //         //     myFavoriteAdsList.refresh();
  //         //   }

  //           adsController.adsDetails.refresh();
  //         }
  //         return true;
  //       } else {
  //         log("==============================Controller: AddToFavorite FAILED");
  //         return false;
  //       }
  //     } catch (e) {
  //       log("==============================Controller: AddToFavorite ERROR");
  //       log("==============================The error is: $e");

  //       onError(e.toString());
  //       return false;
  //     }
  //   }

  Future<void> getMyFavorite(void Function(String e) onError) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: GetMyFavorite IN");
      isLoadingFavorite.value = true;
      myFavoriteAdsList.value = await favoriteService.getMyFavorite();
    } catch (e) {
      log("==============================Controller: GetMyFavorite ERROR");
      log("==============================The error is: $e");
      onError(e.toString());
    } finally {
      isLoadingFavorite.value = false;
    }
  }

  void favoriteAdDetails(int adId) async {
    bool isDone = await addToFavorite(adId, (e) {
      AppSnackbar.showError(e);
    });
    if (isDone) {
      adsController.adsDetails.value!.favorite =
          !adsController.adsDetails.value!.favorite;
    }
  }
}
