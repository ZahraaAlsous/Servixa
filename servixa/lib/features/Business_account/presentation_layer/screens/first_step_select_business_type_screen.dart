import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class FirstStepSelectBusinessTypeScreen extends StatelessWidget {
  const FirstStepSelectBusinessTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 32,
        crossAxisSpacing: 32,
        childAspectRatio: 182 / 113,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          width: size.width * 0.2976,
          decoration: BoxDecoration(color: ThemeApp.Foundation_Main_yellow_50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(IconApp.Balconies),
              Text(
                "Engineering",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
