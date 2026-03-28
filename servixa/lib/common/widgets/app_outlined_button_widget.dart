import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AppOutlinedButtonWidget extends StatelessWidget {
  String textContent;
  void Function()? onPressed;
  bool isRow;
  String icon;
  double? paddingVertical;
  AppOutlinedButtonWidget({
    super.key,
    required this.textContent,
    required this.onPressed,
    this.isRow = true,
    required this.icon,
    this.paddingVertical,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: ThemeApp.Foundation_Main_main_500, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 15),
        child: isRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    // IconApp.camera,
                    icon,
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                  SizedBox(width: 8),
                  Text(
                    textContent,
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  SvgPicture.asset(
                    // IconApp.camera,
                    icon,
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                  Text(
                    textContent,
                    textAlign: TextAlign.center,
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
