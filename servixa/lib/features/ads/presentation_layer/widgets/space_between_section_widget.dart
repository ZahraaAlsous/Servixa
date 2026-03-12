import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';

class SpaceBetweenSectionWidget extends StatelessWidget {
  const SpaceBetweenSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 8,
      color: ThemeApp.Foundation_Secendary_grey_50,
    );
  }
}
