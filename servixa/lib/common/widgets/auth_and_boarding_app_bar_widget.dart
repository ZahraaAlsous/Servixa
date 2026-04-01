import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class AuthAndBoardingAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AuthAndBoardingAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // edit
    // في سهم لازم يطلع من ال get.to
    return AppBar(
      // toolbarHeight : 20,
      actions: [
        TextButton(
          onPressed: () {
            Get.offAll(SuperHomeScreen());
          },
          child: Text(
            "Skip",
            textAlign: TextAlign.center,
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Main_main_500,
            ),
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeApp.linearBackground, ThemeApp.whiteBackground],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
