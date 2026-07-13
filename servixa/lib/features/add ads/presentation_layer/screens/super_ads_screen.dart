import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
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
import 'package:servixa/features/home/business_later/home_controller.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';
import 'package:animations/animations.dart';

class SuperAdsScreen extends StatefulWidget {
  const SuperAdsScreen({super.key});

  @override
  State<SuperAdsScreen> createState() => _SuperAdsScreenState();
}

class _SuperAdsScreenState extends State<SuperAdsScreen> {
  final AdsController adsController = Get.put(AdsController());
  final AddAdsController addAdsController = Get.put(AddAdsController());
  final CategoryController categoryController = Get.put(CategoryController());
  final HomeController homeController = Get.put(HomeController());
  int _currentStep = 0;

  final List<String> _stepTitles = [
    "Select your business account",
    "Select the Main Category",
    "Select the Sub Category",
    "Write Your Ad Details",
    "Add The Location",
  ];

  final List<String> _stepIcon = [
    IconApp.business,
    IconApp.category,
    IconApp.SubCategory,
    IconApp.searchPaper,
    IconApp.SubCategory,
  ];
  final List<Widget> _pages = [
    FirstStepBusinessAccountWidget(),
    SecondStepSelectCategoryWidget(),
    ThirdStepSupCategoryWidget(),
    FourStepWriteAdDetailsWidget(),
    FiveStepAddLocationPage(),
  ];

  bool _isReversing = false;

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
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 400),
                  reverse: _isReversing,
                  transitionBuilder:
                      (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            fillColor: Colors.transparent,
                            child: child,
                          ),
                        );
                      },
                  child: Container(
                    key: ValueKey<int>(_currentStep),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: _pages[_currentStep],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsetsGeometry.symmetric(vertical: 5),
                child: Obx(
                  () => addAdsController.isCreate.value
                      // ? CircularProgressIndicator()
                      ? LoadingAnimationWidget(message: "Wait please...".tr())
                      : _buildNavigationButtons(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(Size size) {
    int numStep =
        addAdsController.selectedCategoryAds.value != null &&
                addAdsController.selectedCategoryAds.value!.hasChildren ||
            addAdsController.selectedSubCategoryAds.value != null
        ? 5
        : 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(numStep, (index) {
          log(
            "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~index: $index + step: $_currentStep",
          );
          numStep == 4 && index >= 2 ? index++ : index;
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
    return
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    AnimatedContainer(
      duration: Duration(seconds: 1),
      margin: EdgeInsetsGeometry.symmetric(horizontal: 1),
      width: size.width * 0.179,
      height: 8.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isActive
            ? ThemeApp.Foundation_Main_main_500
            : ThemeApp.Foundation_Secendary_grey_100,
      ),
      //   ),
      // ],
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
                    _isReversing = true;
                    _currentStep = 1;
                  });
                } else {
                  setState(() {
                    _isReversing = true;
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
                  if (categoryController.categoryQuestions.isEmpty) {
                    addAdsController.finalAnswers.clear();
                    // addAdsController.resetCheckboxes();
                    addAdsController.checkBoxAnswer.clear();
                  }
                  addAdsController.isEditOperation.value
                      ? addAdsController.updateAd(
                          addAdsController.adIdEdit.value!,
                          () {
                            Get.back();
                            AppSnackbar.showSuccess("success update");
                            addAdsController.cleanCleanAd();
                            log(
                              "==============================Controller: UpdateAd OK",
                            );
                          },
                          (e) {
                            AppSnackbar.showError(e);
                          },
                        )
                      : addAdsController.createAd(
                          () {
                            // Get.back();
                            homeController.selectedIndex.value = 2;
                            // Get.offAll(() => SuperHomeScreen());
                            Get.offAll(
                              () => SuperHomeScreen(),
                              arguments: {'selectedIndex': 2},
                            );

                            Future.delayed(Duration(milliseconds: 100), () {
                              homeController.selectedIndex.refresh();
                            });

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

                if (categoryController.isLoadingCategoryQuestions.value) {
                  Get.snackbar(
                    "Alert".tr(),
                    "Please wait a moment while the classification questions are uploaded, if available."
                        .tr(),
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                if (categoryController.hasErrorLoadingCategoryQuestions.value) {
                  Get.snackbar(
                    "Alert".tr(),
                    "Please re-upload the questions for the selected category; and if there are any questions, they should be completed."
                        .tr(),
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                if (addAdsController.selectedMainImage.value == null &&
                    addAdsController.existingMainImageUrl.value.isEmpty) {
                  Get.snackbar(
                    "Alert".tr(),
                    "Please select a main image".tr(),
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                if (addAdsController.listSelectedSubImage.isEmpty &&
                    // addAdsController.existingSubImagesUrls.isEmpty) {
                    addAdsController.existingSubImages.isEmpty) {
                  Get.snackbar(
                    "Alert".tr(),
                    "Please add at least one sub image".tr(),
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
                    "Alert".tr(),
                    "Please agree to the terms and policies".tr(),
                    backgroundColor: ThemeApp.Foundation_Main_main_50,
                    colorText: ThemeApp.Foundation_Main_main_500,
                  );
                  return;
                }

                setState(() {
                  _isReversing = false;
                  _currentStep = 4;
                });
                return;
              }

              if (addAdsController.validateStepAddAds(_currentStep)) {
                if (_currentStep == 1) {
                  // addAdsController.selectedSubCategoryAds.value = null;
                  final bool hasCategory =
                      addAdsController.selectedCategoryAds.value != null;
                  final bool hasChildren =
                      hasCategory &&
                      addAdsController.selectedCategoryAds.value!.hasChildren;
                  final bool hasSubCategory =
                      addAdsController.selectedSubCategoryAds.value != null;
                  final bool hasSubCategoryParent =
                      !hasCategory &&
                      hasSubCategory &&
                      addAdsController.selectedSubCategoryAds.value!.parentId !=
                          null;
                  final bool isCategoryChanged =
                      addAdsController.oldCategoryId !=
                          addAdsController.selectedCategoryAdsId.value ||
                      addAdsController.oldSupCategoryId !=
                          addAdsController.selectedSubCategoryAdsId.value;

                  if (hasChildren || hasSubCategoryParent) {
                    if (isCategoryChanged) {
                      addAdsController.prepareForNewCategory();
                    }
                    categoryController.getCategoryQuestions(
                      addAdsController.selectedCategoryAdsId.value!,
                      false,
                    );
                    categoryController.getSubCategories(
                      addAdsController.selectedCategoryAdsId.value!,
                    );
                    setState(() {
                      _isReversing = false;
                      _currentStep = 2;
                    });
                  } else {

                    if (isCategoryChanged) {
                      addAdsController.prepareForNewCategory();
                    }
                    addAdsController.selectedSubCategoryAds.value = null;
                    addAdsController.selectedSubCategoryAdsId.value = null;
                    categoryController.getCategoryQuestions(
                      addAdsController.selectedCategoryAdsId.value!,
                      false,
                    );
                    setState(() {
                      _isReversing = false;
                      _currentStep = 3;
                    });
                  }
                } else if (_currentStep == 2) {
                  final bool isCategoryChanged =
                      addAdsController.oldCategoryId !=
                          addAdsController.selectedCategoryAdsId.value ||
                      addAdsController.oldSupCategoryId !=
                          addAdsController.selectedSubCategoryAdsId.value;
                  if (categoryController.supCategoryQuestion.isNotEmpty && isCategoryChanged) {
                    for (var question
                        in categoryController.supCategoryQuestion) {
                      String key = "custom_fields[${question.id}]";

                      log(
                        "/+++++++++++++++++++++++++++++++++++++++++${addAdsController.finalAnswers}",
                      );

                      addAdsController.finalAnswers[key] = "";
                      log(
                        "+++++++++++++++++++++++++++++++++++++++++${addAdsController.finalAnswers}",
                      );
                      log(
                        "/+++++++++++++++++++++++++++++++++++++++++${addAdsController.oldAnswers}",
                      );

                      addAdsController.oldAnswers.remove(key);
                      addAdsController.oldAnswers[key] = "";
                      log(
                        "+++++++++++++++++++++++++++++++++++++++++${addAdsController.oldAnswers}",
                      );

                      log(
                        "/+++++++++++++++++++++++++++++++++++++++++${addAdsController.checkBoxAnswer}",
                      );

                      // تنظيف checkBoxAnswer
                      addAdsController.checkBoxAnswer.remove(question.id);
                      log(
                        "+++++++++++++++++++++++++++++++++++++++++${addAdsController.checkBoxAnswer}",
                      );
                      log(
                        "/+++++++++++++++++++++++++++++++++++++++++${addAdsController.radioAnswer}",
                      );

                      addAdsController.radioAnswer.remove(question.id);
                      log(
                        "+++++++++++++++++++++++++++++++++++++++++${addAdsController.radioAnswer}",
                      );
                    }

                    log(
                      "Cleaned answers for previous sub-category questions: ${categoryController.supCategoryQuestion.map((q) => q.id).toList()}",
                    );
                  }
                  if (addAdsController.selectedSubCategoryAds.value != null) {
                    // addAdsController.cleanAnswerOldQuestion;

                    categoryController.getCategoryQuestions(
                      addAdsController.selectedSubCategoryAds.value!.id,
                      true,
                    );
                    setState(() {
                      _isReversing = false;
                      _currentStep = 3;
                    });
                  } else {
                    Get.snackbar(
                      "Alert".tr(),
                      "Please select a sub category".tr(),
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
                  "Alert".tr(),
                  "This step is required".tr(),
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
