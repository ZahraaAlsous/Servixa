import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/rate/business_later/rate_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/const/dimens_app.dart';

class DetailsBottomNavigationBarWidget extends StatelessWidget {
  void Function()? onPressedButtonOutBorder;
  String textButtonOutBorder;
  String textButtonElevetedBorder;
  void Function()? onPressedButtonElevetedBorder;
  String iconButtonOutBorder;
  String iconButtonElevetedBorder;
  DetailsBottomNavigationBarWidget({
    super.key,
    required this.textButtonOutBorder,
    required this.textButtonElevetedBorder,
    required this.onPressedButtonOutBorder,
    required this.onPressedButtonElevetedBorder,
    required this.iconButtonOutBorder,
    required this.iconButtonElevetedBorder,
  });
  final RateController rateController = Get.put(RateController());

  @override
  Widget build(BuildContext context) {
    final widthScreen = Get.width;

    return 
    Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
        vertical: 0,
      ),
      child: 
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: ThemeApp.Foundation_Main_main_500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPressedButtonOutBorder,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    // IconApp.messages,
                    iconButtonOutBorder,
                    width: 20,
                    height: 20,
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                  Text(
                    textButtonOutBorder.tr(),
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeApp.Foundation_Main_main_500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPressedButtonElevetedBorder,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    // IconApp.badgePercent,
                    iconButtonElevetedBorder,
                    width: 20,
                    height: 20,
                    color: ThemeApp.Foundation_Main_yellow_50,
                  ),

                  Text(
                    textButtonElevetedBorder.tr(),
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_yellow_50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    
    );
  }
}
