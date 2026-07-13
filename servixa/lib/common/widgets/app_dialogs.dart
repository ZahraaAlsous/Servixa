import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AppDialogs {
  static void showConfirmation({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = "Delete",
    String cancelText = "Cancel",
    Color? confirmButtonColor,
    Color? titleColor,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: ThemeApp.Foundation_Main_main_50,
        title: Text(
          title.tr(),
          // style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          style: TypographyApp.Title_larg_Mid.copyWith(
            color: titleColor ?? ThemeApp.Foundation_Statue_Red,
          ),
        ),
        content: Text(
          message.tr(),
          // style: const TextStyle(fontSize: 14, color: Colors.black87),
          style: TypographyApp.Body_mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_300,
          ),
        ),
        actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Secendary_grey_200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              cancelText.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  confirmButtonColor ?? ThemeApp.Foundation_Statue_Red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: Text(
              confirmText.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible:
          false,
    );
  }
}
