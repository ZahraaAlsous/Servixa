import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';

class AppSnackbar {
  static void showError(String message) {
    Get.snackbar(
      "Alert".tr(),
      message,
      // snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ThemeApp.Foundation_Statue_Red.withOpacity(0.5),
      colorText: Colors.white,
      icon: const Icon(Icons.error_outline, color: ThemeApp.whiteBackground),
      duration: const Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          "Close".tr(),
          style: TextStyle(color: ThemeApp.whiteBackground),
        ),
      ),
    );
  }

  static void showSuccess(String message) {
    Get.snackbar(
      "Successfully completed".tr(),
      message.tr(),
      // snackPosition: SnackPosition.BOTTOM,
      // backgroundColor: Colors.green.withOpacity(0.8),
      backgroundColor: ThemeApp.Foundation_Main_main_50,
      colorText: ThemeApp.Foundation_Main_main_500,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }

  static void showAlert(String message) {
    Get.snackbar(
      "Alert".tr(),
      message.tr(),
      // snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ThemeApp.Foundation_Main_main_50,
      colorText: ThemeApp.Foundation_Main_main_500,
      // icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }
}
