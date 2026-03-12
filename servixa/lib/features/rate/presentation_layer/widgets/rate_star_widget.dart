import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class RateStarWidget extends StatelessWidget {
  int percent;
  int numberStar;
  double widthBarPercentage;
  RateStarWidget({
    super.key,
    required this.percent,
    required this.numberStar,
    required this.widthBarPercentage,
  });
  Widget _percentageBar(double percent) {
    return SizedBox(
      width: widthBarPercentage,
      child: LinearProgressIndicator(
        value: percent,
        backgroundColor: ThemeApp.Foundation_Secendary_Color_Light_hover,
        valueColor: AlwaysStoppedAnimation<Color>(
          ThemeApp.Foundation_Main_main_500,
        ),
        minHeight: 7.18,
        borderRadius: BorderRadius.circular(13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "${percent}%",
            style: TypographyApp.Label_Mid_Mid.copyWith(
              color: ThemeApp.gray_scale_Most_Dark,
            ),
          ),
          const SizedBox(width: 10),
          _percentageBar(percent / 100),
          SvgPicture.asset(
            IconApp.starFill,
            width: 17,
            height: 17,
            color: ThemeApp.Foundation_Main_main_500,
          ),
          Text(
            numberStar.toString(),
            style: TypographyApp.Label_Mid_Mid.copyWith(
              color: ThemeApp.gray_scale_Most_Dark,
            ),
          ),
        ],
      ),
    );
  }
}
