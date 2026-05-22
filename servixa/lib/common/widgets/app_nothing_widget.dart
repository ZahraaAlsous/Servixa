import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AppNothingWidget extends StatelessWidget {
  const AppNothingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage(ImageApp.nothing)),
        Text(
          "Nothing Here Yet".tr(),
          style: TypographyApp.Title_larg_Mid.copyWith(
            color: ThemeApp.Foundation_Main_main_500,
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          "No content is available right now. Please try again later.".tr(),
          style: TypographyApp.Title_Mid_Regular.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_300,
          ),
        ),
      ],
    );
  }
}
