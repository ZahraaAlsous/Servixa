import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/features/rate/data_layer/models/review_rate_model.dart';
import 'package:servixa/features/rate/data_layer/sourses/rate_service.dart';

class RateController extends GetxController {
  final RateService rateService = RateService();
  RxBool isAddRateNow = false.obs;
  RxBool isLoadingRateNow = false.obs;
  final TextEditingController commentController = TextEditingController();
  RxInt rate = 0.obs;
  Rx<ReviewRateModel?> ratesReview = Rx<ReviewRateModel?>(null);

  Future<void> addRate(
    int adId,
    void Function(String message) onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isAddRateNow.value = true;
      bool canRate = await rateService.addRate(
        adId: adId,
        rate: rate.value,
        comment: commentController.text.trim(),
      );
      if (canRate) {
        onSuccess(
          "The review has been successfully added; it will be reviewed and then published.",
        );
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      isAddRateNow.value = false;
    }
  }

  bool validateStars(void Function() onAlert) {
    if (rate.value == 0) {
      onAlert();
      return false;
    }
    return true;
  }

  void cleanRateFailed() {
    rate.value = 0;
    commentController.clear();
  }

  Future<void> getRateReview(int adId, void Function(String e) onError) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : GetRateReview IN");

      isLoadingRateNow.value = true;
      ratesReview.value = await rateService.getRateReview(adId: adId);
      log("==============================Controller : GetRateReview OK");
    } catch (e) {
      log("==============================Controller : GetRateReview ERROR");
      log("==============================The error is : $e");

      onError(e.toString());
    } finally {
      isLoadingRateNow.value = false;
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    rate.value = 0;
    super.dispose();
  }
}
