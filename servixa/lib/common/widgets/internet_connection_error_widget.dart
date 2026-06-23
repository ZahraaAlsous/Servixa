import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:lottie/lottie.dart';

class InternetConnectionErrorWidget extends StatelessWidget {
  final void Function()? onPressed;
  InternetConnectionErrorWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Icon(
          //   Icons.wifi_off,
          //   size: 64,
          //   color: ThemeApp.Foundation_Secendary_grey_100,
          // ),
          Lottie.asset(
            'assets/animations/net.json',
            width: 100,
            height: 100,
          ),
          // const SizedBox(height: 16),
          Text(
            'No internet connection or server error'.tr(),
            style: TypographyApp.Title_Mid_Regular.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_300,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              'Try Again'.tr(),
              style: TypographyApp.Label_Mid_Regular.copyWith(
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
