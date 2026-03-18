import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_app_bar_widget.dart';
import 'package:servixa/features/bording/business_later/bording_controller.dart';
import 'package:servixa/features/bording/presentation_layer/screens/bording_one_screen.dart';
import 'package:servixa/features/bording/presentation_layer/screens/bording_second_screen.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class SuperBordingScreen extends StatelessWidget {
  final BordingController bordingController = Get.put(BordingController());
  RxInt _currentStep = 0.obs;

  SuperBordingScreen({super.key});
  List<Widget> _pages = [BordingOneScreen(), BordingSecondScreen()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AuthAppBarWidget(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
          vertical: 5,
        ),
        child: Column(
          children: [
            Obx(() => Expanded(flex: 170, child: _pages[_currentStep.value])),

            Obx(() => Expanded(flex: 15, child: _buildStepIndicator(size))),

            Expanded(
              flex: 15,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (_currentStep.value > 0) {
                          _currentStep.value--;
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Adjust the radius as needed
                        ),
                      ),
                      child: Text(
                        'Previous',
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 21),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentStep.value < _pages.length - 1) {
                          _currentStep.value++;
                        } else {
                          Get.to(SuperHomeScreen());
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeApp.Foundation_Main_main_500,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Next',
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

  Widget _buildStepIndicator(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return _buildStepCircle(
            index: index,
            isActive: index == _currentStep.value,
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
    required Size size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsetsGeometry.symmetric(horizontal: 1),
          width: size.width * (isActive ? 0.081 : 0.037),
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
