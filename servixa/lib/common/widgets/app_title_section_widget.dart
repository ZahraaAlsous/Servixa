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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data,
          style:
              typographyAppTitle ??
              TypographyApp.title_home_page.copyWith(
                color: ThemeApp.Foundation_Main_Color_900,
              ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Show All",
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
