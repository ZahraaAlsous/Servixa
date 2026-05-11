import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/first_step_business_account_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/five_step_add_location_page.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/four_step_write_ad_details_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/second_step_select_category_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/third_step_sup_category_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';

class SuperAdsScreen extends StatefulWidget {
  SuperAdsScreen({super.key});

  @override
  State<SuperAdsScreen> createState() => _SuperAdsScreenState();
}

class _SuperAdsScreenState extends State<SuperAdsScreen> {
  final AdsController adsController = Get.put(AdsController());
  final AddAdsController addAdsController = Get.put(AddAdsController());
  final CategoryController categoryController = Get.put(CategoryController());
  int _currentStep = 0;

  List<String> _stepTitles = [
    "Select your business account",
    "Select the Main Category",
    "Select the Sub Category",
    "Write Your Ad Details",
    "Add The Location",
  ];

  List<String> _stepIcon = [
    IconApp.business,
    IconApp.category,
    IconApp.SubCategory,
    IconApp.searchPaper,
    IconApp.SubCategory,
  ];
  List<Widget> _pages = [
    FirstStepBusinessAccountWidget(),
    SecondStepSelectCategoryWidget(),
    ThirdStepSupCategoryWidget(),
    FourStepWriteAdDetailsWidget(),
    FiveStepAddLocationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        addAdsController.cleanCleanAd();
        log("===============================Screen: Clear Data CreateAd");
        return true;
      },
      child: Scaffold(
        backgroundColor: ThemeApp.whiteBackground,
        appBar: AppBarWidget(),
        body: Padding(
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
                  borderRadius: BorderRadius.circular(26),
                ),
                // edit
                // يمكن صورة من الباك
                child: SvgPicture.asset(
                  _stepIcon[_currentStep],
                  width: 48,
                  height: 48,
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _stepTitles[_currentStep].tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(child: _pages[_currentStep]),
              ),
              const SizedBox(height: 10),

              Obx(
                () => addAdsController.isCreate.value
                    ? CircularProgressIndicator()
                    : _buildNavigationButtons(),
              ),
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
        // children: List.generate(5, (index) {
        children: List.generate(5, (index) {
          return _buildStepCircle(
            index: index,
            isActive: index <= _currentStep,
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
          width: size.width * 0.179,
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
        if (_currentStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                if (_currentStep == 3 &&
                    addAdsController.selectedSubCategoryAds.value == null) {
                  setState(() {
                    _currentStep = 1;
                  });
                } else {
                  setState(() {
                    _currentStep--;
                  });
                }
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

        if (_currentStep > 0) const SizedBox(width: 10),

        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_currentStep == 4) {
                if (categoryController.categoryQuestions.isEmpty) {
                  addAdsController.checkboxStates.clear();
                  addAdsController.finalAnswers.clear();
                }
                if(categoryController.categoryQuestions.isNotEmpty){
                  addAdsController.collectCheckboxAnswers();
                }
                if (!addAdsController.formKey2.currentState!.validate()) {
                  return;
                }
                if (addAdsController.selectedLatLng.value == null) {
                  Get.snackbar(
                    "Alert",
                    "Please select your location on the map",
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                } else {
                  addAdsController.createAd(
                    () {
                      Get.back();
                      AppSnackbar.showSuccess("Ad created successfully");
                      addAdsController.cleanCleanAd();
                    },
                    (error) {
                      AppSnackbar.showError(error);
                    },
                  );
                  return;
                }
              }

              if (_currentStep == 3) {
                if (!addAdsController.formKey.currentState!.validate()) {
                  // addAdsController.collectCheckboxAnswers();
                  return;
                }

                if (addAdsController.selectedMainImage.value == null) {
                  Get.snackbar(
                    "Alert",
                    "Please select a main image",
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                if (addAdsController.listSelectedSubImage == null ||
                    addAdsController.listSelectedSubImage.isEmpty) {
                  Get.snackbar(
                    "Alert",
                    "Please add at least one sub image",
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                if (!addAdsController.validateDynamicQuestions()) {
                  return;
                }
                if (addAdsController.isAgree()) {
                  Get.snackbar(
                    "Alert",
                    "Please agree to the terms and policies",
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                setState(() {
                  _currentStep = 4;
                });
                return;
              }

              if (addAdsController.validateStepAddAds(_currentStep)) {
                if (_currentStep == 1) {
                  addAdsController.selectedSubCategoryAds.value = null;

                  if (addAdsController.selectedCategoryAds.value!.hasChildren) {
                    categoryController.getSubCategories(
                      addAdsController.selectedCategoryAds.value!.id,
                    );
                    setState(() {
                      _currentStep = 2;
                    });
                  } else {
                    categoryController.getCategoryQuestions(
                      addAdsController.selectedCategoryAds.value!.id,
                    );
                    setState(() {
                      _currentStep = 3;
                    });
                  }
                } else if (_currentStep == 2) {
                  if (addAdsController.selectedSubCategoryAds.value != null) {
                    categoryController.getCategoryQuestions(
                      addAdsController.selectedSubCategoryAds.value!.id,
                    );
                    setState(() {
                      _currentStep = 3;
                    });
                  } else {
                    Get.snackbar(
                      "Alert",
                      "Please select a sub category",
                      backgroundColor: ThemeApp.Foundation_Main_main_50,
                      colorText: ThemeApp.Foundation_Main_main_500,
                    );
                  }
                } else {
                  setState(() {
                    _currentStep++;
                  });
                }
              } else {
                Get.snackbar(
                  "Alert",
                  "This step is required",
                  backgroundColor: ThemeApp.Foundation_Main_main_50,
                  colorText: ThemeApp.Foundation_Main_main_500,
                );
              }
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              _currentStep == 4 ? 'Submit'.tr() : 'Next'.tr(),
              style: TypographyApp.Body_mid_Mid.copyWith(
                color: ThemeApp.Foundation_Main_main_50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
