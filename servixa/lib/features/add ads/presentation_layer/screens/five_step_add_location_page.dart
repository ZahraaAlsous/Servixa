import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servixa/common/widgets/app_map_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class FiveStepAddLocationPage extends StatelessWidget {
  FiveStepAddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconApp.place),
            Text(
              "742 Evergreen Terrace, Springfield",
              style: TypographyApp.Body_mid_Regular.copyWith(
                color: ThemeApp.Foundation_Secendary_grey_300,
              ),
            ),
          ],
        ),
        AppMapWidget()
      ],
    );
  }
}
