import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class BoardingSecondScreen extends StatelessWidget {
  const BoardingSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage(ImageApp.bording2)),
        Text(
          "titleOnBoarding2".tr(),
          textAlign: TextAlign.center,
          style: TypographyApp.Headline_larg_mid,
        ),

        Text(
          "textOnBoarding2".tr(),
          textAlign: TextAlign.center,
          style: TypographyApp.Title_Mid_Regular,
        ),
      ],
    );
  }
}
