import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/auth_and_boarding_app_bar_widget.dart';
import 'package:servixa/features/auth/presentation_layer/screens/login_page.dart';
import 'package:servixa/features/boarding/business_later/boarding_controller.dart';
import 'package:servixa/features/boarding/presentation_layer/screens/boarding_one_screen.dart';
import 'package:servixa/features/boarding/presentation_layer/screens/boarding_second_screen.dart';

class SuperBoardingScreen extends StatelessWidget {
  final BoardingController boardingController = Get.put(BoardingController());
  final List<Widget> _pages = const [
    BoardingOneScreen(),
    BoardingSecondScreen(),
  ];

  SuperBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final size = Get.width;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AuthAndBoardingAppBarWidget(whereGo: LoginPage()),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          // horizontal: size.width * DimensApp.spaceHorizontalScreen,
          horizontal: size * DimensApp.spaceHorizontalScreen,
          vertical: 5,
        ),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                flex: 170,
                child: _pages[boardingController.currentStep.value],
              ),
            ),

            Obx(() => Expanded(flex: 15, child: _buildStepIndicator(size))),

            Expanded(
              flex: 15,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (boardingController.currentStep.value > 0) {
                          boardingController.currentStep.value--;
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        side: const BorderSide(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Adjust the radius as needed
                        ),
                      ),
                      child: Text(
                        'Previous'.tr(),
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 21),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (boardingController.currentStep.value <
                            _pages.length - 1) {
                          boardingController.currentStep.value++;
                        } else {
                          // Get.to(SuperHomeScreen());
                          Get.offAll(LoginPage());
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeApp.Foundation_Main_main_500,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Next'.tr(),
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_main_50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildStepIndicator(Size size) {
  Widget _buildStepIndicator(double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return _buildStepCircle(
            index: index,
            isActive: index == boardingController.currentStep.value,
            size: size,
          );
        }),
      ),
    );
  }

  Widget _buildStepCircle({
    required int index,
    required bool isActive,
    // required bool isCurrent,
    // required Size size,
    required double size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsetsGeometry.symmetric(horizontal: 1),
          // width: size.width * (isActive ? 0.081 : 0.037),
          width: size * (isActive ? 0.081 : 0.037),
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: isActive
                ? ThemeApp.Foundation_Main_main_500
                : ThemeApp.Foundation_Secendary_grey_100,
          ),
        ),
      ],
    );
  }
}
