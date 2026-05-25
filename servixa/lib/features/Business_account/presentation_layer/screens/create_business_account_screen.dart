import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/Second_step_business_account_details_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/first_step_select_business_type_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/four_step_business_account_document_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/third_step_business_account_contact_information_screen.dart';

class CreateBusinessAccountScreen extends StatelessWidget {
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );

  final List<String> _stepTitles = [
    "Select a Business Profile Type",
    "Enter The Business Details",
    "Enter Contact Information",
    "Upload Supporting Document",
  ];

  final List<String> _stepIcon = [
    IconApp.businessProfileType,
    IconApp.businessDetails,
    IconApp.contactInformation,
    IconApp.businessProfileType,
  ];

  final List<Widget> _pages = [
    FirstStepSelectBusinessTypeScreen(),
    SecondStepBusinessAccountDetailsScreen(),
    ThirdStepBusinessAccountContactInformationScreen(),
    FourStepBusinessAccountDocumentScreen(),
  ];

  CreateBusinessAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    businessAccountController.agreeLoadingCitiesAndUserTypes.value = true;

    return WillPopScope(
      onWillPop: () async {
        businessAccountController.clearData();
        log(
          "===============================Screen: Clear Data CreateBusinessAccount",
        );
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: size.width * DimensApp.spaceHorizontalScreen,
          ),
          child: Column(
            children: [
              _buildStepIndicator(size),
              Container(
                width: size.width * 0.23488,
                height: size.width * 0.23488,
                alignment: AlignmentGeometry.center,
                decoration: BoxDecoration(
                  color: ThemeApp.Foundation_Main_main_100,
                  borderRadius: BorderRadius.circular(78),
                ),
                child: Obx(() {
                  log(
                    'Loading icon: ${_stepIcon[businessAccountController.currentStep.value]}',
                  );
                  return SvgPicture.asset(
                    _stepIcon[businessAccountController.currentStep.value],
                    // IconApp.notification,
                    width: 48,
                    height: 48,
                    color: ThemeApp.Foundation_Main_main_500,
                  );
                }),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Text(
                  _stepTitles[businessAccountController.currentStep.value].tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: size.width * DimensApp.spaceHorizontalScreen,
              //   ),
              //   child:
              Obx(() => _pages[businessAccountController.currentStep.value]),
              // ),
              const SizedBox(height: 10),

              //  _buildNavigationButtons(),
              Obx(() {
                return businessAccountController
                        .isLoadingCreateBusinessAccount
                        .value
                    // ? Center(child: CircularProgressIndicator())
                    ? LoadingAnimationWidget(message: "Wait please...",)
                    : _buildNavigationButtons();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return Obx(
            () => _buildStepCircle(
              index: index,
              isActive: index <= businessAccountController.currentStep.value,
              size: size,
            ),
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
          width: size.width * 0.2145,
          height: 8.5,
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

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (businessAccountController.currentStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // setState(() {
                businessAccountController.currentStep.value--;
                // });
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                side: BorderSide(color: ThemeApp.Foundation_Main_main_500),
              ),
              child: Text(
                'Previous'.tr(),
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
            ),
          ),

        if (businessAccountController.currentStep > 0)
          const SizedBox(width: 10),

        // Obx(() {
        //   if (businessAccountController.isLoading.value) {
        //     return Center(child: CircleAvatar());
        //   }
        // return
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (businessAccountController.currentStep.value == 0) {
                // busiessAccountController.getCities((e) {
                //   AppSnackbar.showError(e);
                // });
                if (businessAccountController.selectedUserTypeId.value == 0) {
                  AppSnackbar.showError("Please select user type");
                  return;
                }
                businessAccountController.currentStep.value++;
              } else if (businessAccountController.currentStep.value == 2) {
                final currentFormKey = businessAccountController.formKeys[2];
                bool isFormValid =
                    currentFormKey.currentState?.validate() ?? false;
                bool isLocationSelected =
                    businessAccountController.selectedLatLng.value != null;
                if (isFormValid && isLocationSelected) {
                  businessAccountController.currentStep.value++;
                } else {
                  if (!isFormValid) {
                    AppSnackbar.showError("Please fill all required fields");
                  } else if (!isLocationSelected) {
                    AppSnackbar.showError(
                      "Please select your location on the map",
                    );
                  }
                }
              } else {
                final currentFormKey = businessAccountController
                    .formKeys[businessAccountController.currentStep.value];
                if (currentFormKey.currentState?.validate() ?? true) {
                  if (businessAccountController.currentStep.value < 3) {
                    businessAccountController.currentStep.value++;
                  } else {
                    log(
                      "******************************Click Submit CreateBusinessAccount",
                    );
                    businessAccountController.createBusinessAccount(
                      () {
                        Get.back();
                        AppSnackbar.showSuccess("Account created successfully");
                      },
                      (e) {
                        AppSnackbar.showError(e);
                      },
                    );
                  }
                } else {
                  AppSnackbar.showError(
                    "Please fill all required fields correctly",
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              businessAccountController.currentStep == 3 ? 'Submit'.tr() : 'Next'.tr(),
              style: TypographyApp.Body_mid_Mid.copyWith(
                color: ThemeApp.Foundation_Main_main_50,
              ),
            ),
          ),
          //   );
          // }
        ),
      ],
    );
  }
}
