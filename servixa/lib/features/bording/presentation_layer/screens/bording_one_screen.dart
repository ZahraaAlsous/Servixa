import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class BordingOneScreen extends StatelessWidget {
  const BordingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(ImageApp.bording1)),
        Text(
          "Discover Services or Promote Your Own",
          textAlign: TextAlign.center,
          style: TypographyApp.Headline_larg_mid.copyWith(
            color: ThemeApp.black,
          ),
        ),

        Text(
          "Looking for services or offering them? Easily browse categories or post your own ads to reach a wider audience.",
          textAlign: TextAlign.center,
          style: TypographyApp.Title_Mid_Regular.copyWith(
            color: ThemeApp.black,
          ),
        ),
      ],
    );
  }
}
