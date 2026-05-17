import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/features/rate/data_layer/sourses/rate_service.dart';

class RateController extends GetxController {
  final RateService rateService = RateService();
  RxBool isAddRateNow = false.obs;
  final TextEditingController commentController = TextEditingController();
  RxInt rate = 0.obs;
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

  @override
  void dispose() {
    commentController.dispose();
    rate.value = 0;
    super.dispose();
  }
}
