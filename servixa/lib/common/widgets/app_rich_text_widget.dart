import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';

class AppRichTextWidget extends StatelessWidget {
  String firstText;
  String secondText;
  Color? colorFirstText;
  Color? colorSecondText;
  TextStyle typographyApp;
  int? maxLines;
  AppRichTextWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    this.colorFirstText,
    this.colorSecondText,
    required this.typographyApp,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines ?? 1,
      text: TextSpan(
        style: typographyApp,
        children: [
          TextSpan(
            text: firstText.tr(),
            style: TextStyle(
              color: colorFirstText ?? ThemeApp.Foundation_Secendary_grey_700,
            ),
          ),
          TextSpan(
            text: secondText.tr(),
            style: TextStyle(
              color: colorSecondText ?? ThemeApp.Foundation_Main_main_500,
            ),
          ),
        ],
      ),
    );
  }
}
