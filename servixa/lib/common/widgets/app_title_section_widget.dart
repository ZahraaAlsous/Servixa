// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AppTitleSectionWidget extends StatelessWidget {
  String data;
  TextStyle? typographyAppTitle;
  TextStyle? typographyAppButton;
  void Function()? onPressed;
  AppTitleSectionWidget({
    super.key,
    required this.data,
    this.onPressed,
    this.typographyAppTitle,
    this.typographyAppButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            data.tr(),
            style:
                typographyAppTitle ??
                TypographyApp.title_Sections.copyWith(
                  color: ThemeApp.Foundation_Main_Color_900,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "ShowAll".tr(),
            style:
                typographyAppButton ??
                TypographyApp.text_button_home_page.copyWith(
                  color: ThemeApp.Foundation_Main_main_500,
                ),
          ),
        ),
      ],
    );
  }
}
