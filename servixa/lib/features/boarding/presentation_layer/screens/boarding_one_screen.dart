import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class BoardingOneScreen extends StatelessWidget {
  const BoardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage(ImageApp.bording1)),
        Text(
          "titleOnBoarding1".tr(),
          textAlign: TextAlign.center,
          style: TypographyApp.Headline_larg_mid.copyWith(
            color: ThemeApp.black,
          ),
        ),

        Text(
          "textOnBoarding1".tr(),
          textAlign: TextAlign.center,
          style: TypographyApp.Title_Mid_Regular.copyWith(
            color: ThemeApp.black,
          ),
        ),
      ],
    );
  }
}
