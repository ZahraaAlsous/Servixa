import 'package:flutter/material.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/utils/validators.dart';

class AdsTextAreaWidget extends StatelessWidget {
  String hintText;
  String prefixIcon;
  TextEditingController controller;
  AdsTextAreaWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      maxLines: 10,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // hintText: "Enter Details",
        hintText: hintText,
        hintStyle: TypographyApp.Body_mid_Regular.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_200,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: ThemeApp.Foundation_Secendary_grey_200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: ThemeApp.Foundation_Secendary_grey_100,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SvgPicture.asset(
                // IconApp.details,
                prefixIcon,
                width: 20,
                height: 20,
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
          ],
        ),
      ),
      controller: controller,
      // note
      // تأكل إذا حقل الرأي و حقل تفاصيل الطلب مطلوب أو لا
      validator: Validators.validateReviewAndRequestOrder,
    );
  }
}
