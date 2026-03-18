import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class BordingSecondScreen extends StatelessWidget {
  const BordingSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(ImageApp.bording2)),
        Text(
          "Smart Solutions for Every Project",
          textAlign: TextAlign.center,
          style: TypographyApp.Headline_larg_mid,
        ),

        Text(
          "Whether it’s plumbing, electrical work, interior design, or general maintenance—our platform connects you with trusted experts.",
          textAlign: TextAlign.center,
          style: TypographyApp.Title_Mid_Regular,
        ),
      ],
    );
  }
}
