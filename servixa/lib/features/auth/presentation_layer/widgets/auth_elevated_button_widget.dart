import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AuthElevatedButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? colorButton;
  const AuthElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final size = Get.width;

    return SizedBox(
      // width: size.width * 0.934,
      width: size * 0.934,
      // height: size.height * 0.051,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: 
        Text(
          text.tr(),
          style: TypographyApp.Body_mid_Mid.copyWith(
            color: ThemeApp.Foundation_Main_yellow_50,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton ?? ThemeApp.Foundation_Main_main_500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
