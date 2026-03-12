import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AuthElevatedButtonWidget extends StatelessWidget {
  String text;
  void Function()? onPressed;
  Color? colorButton;
  AuthElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.934,
      // height: size.height * 0.051,
    height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TypographyApp.Body_mid_Mid.copyWith(
            color: ThemeApp.Foundation_Main_yellow_50,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton?? ThemeApp.Foundation_Main_main_500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
