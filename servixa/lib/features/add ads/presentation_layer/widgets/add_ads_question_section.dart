import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';

class AddAdsQuestionSection extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final AddAdsController addAdsController = Get.put(AddAdsController());
  AddAdsQuestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoadingCategoryQuestions.value) {
        // return Center(child: CircularProgressIndicator());
        return LoadingAnimationWidget(
          message: "Loading dynamic questions...".tr(),
        );
      } else if (categoryController.hasErrorLoadingCategoryQuestions.value) {
        return InternetConnectionErrorWidget(
          onPressed: () async {
            // categoryController.getCategoryQuestions(
            //   addAdsController.selectedSubCategoryAds.value != null
            //       ? addAdsController.selectedSubCategoryAds.value!.id
            //       : addAdsController.selectedCategoryAds.value!.id,
            // );
            await categoryController.getCategoryQuestions(
              addAdsController.selectedSubCategoryAds.value!.id,
              true,
            );
            await categoryController.getCategoryQuestions(
              addAdsController.selectedCategoryAds.value!.id,
              false,
            );
          },
        );
      } else {
        if (categoryController.categoryQuestions.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categoryController.categoryQuestions.length,
            itemBuilder: (context, indexQuestion) {
              CategoryQuestionModel question =
                  categoryController.categoryQuestions[indexQuestion];
              if (question.type == "text") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          question.question,
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_600,
                          ),
                        ),
                        Text(
                          question.unitOfMeasurement == null
                              ? ""
                              : "(${question.unitOfMeasurement})",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      hintText: question.metaData.hint ?? question.question,
                      // icon: IconApp.tags,
                      // controller: titleController,
                      initialValue:
                          addAdsController
                              .finalAnswers["custom_fields[${question.id}]"] ??
                          "",
                      // validator: (value) =>
                      //     Validators.validateTextDinamckQuestion(
                      //       value,
                      //       question.question,
                      //       question.metaData.is_required,
                      //     ),
                      onChanged: (value) {
                        // addAdsController.adTitle = value;
                        addAdsController.saveSimpleAnswer(question.id, value);
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              } else if (question.type == "number") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          question.question,
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_600,
                          ),
                        ),
                        Text(
                          question.unitOfMeasurement == null
                              ? ""
                              : "(${question.unitOfMeasurement})",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    AppTextFormField(
                      hintText: question.metaData.hint ?? question.question,
                      // icon: IconApp.tags,
                      keyboardType: TextInputType.number,
                      // controller: titleController,
                      initialValue:
                          addAdsController
                              .finalAnswers["custom_fields[${question.id}]"] ??
                          "",
                      validator: (value) =>
                          Validators.validateNumberDinamickQuestion(
                            value,
                            question.question,
                            question.metaData.is_required,
                          ),
                      onChanged: (value) {
                        // addAdsController.adTitle = value;
                        addAdsController.saveSimpleAnswer(question.id, value);
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              } else if (question.type == "select") {
                String? savedValue = addAdsController
                    .finalAnswers["custom_fields[${question.id}]"];

                List<String> options = question.metaData.options ?? [];

                String? validValue =
                    (savedValue != null && options.contains(savedValue))
                    ? savedValue
                    : null;

                log("Question: ${question.question}");
                log("Saved value: '$savedValue'");
                log("Options: $options");
                log("Valid value: '$validValue'");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          question.question,
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_600,
                          ),
                        ),

                        Text(
                          question.unitOfMeasurement == null
                              ? ""
                              : "(${question.unitOfMeasurement})",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_200,
                          ),
                        ),
                      ],
                    ),

                    AppDropdownButtonFormFieldWidget(
                      hintText: question.question,
                      // value: addAdsController
                      //     .finalAnswers["custom_fields[${question.id}]"],
                      value: validValue,
                      // initialValue: addAdsController
                      //     .finalAnswers["custom_fields[${question.id}]"],
                      onChanged: (value) {
                        if (value is String) {
                          addAdsController.saveSimpleAnswer(question.id, value);
                        }
                      },
                      validator: (value) {
                        final stringValue = value?.toString();

                        if (question.metaData.is_required) {
                          if (stringValue == null || stringValue.isEmpty) {
                            return "${question.question}" + " is required".tr();
                          }
                        }

                        // if (stringValue != null && stringValue.isNotEmpty) {
                        //   return Validators.validateTextDinamckQuestion(
                        //     stringValue,
                        //     question.question,
                        //     question.metaData.is_required,
                        //   );
                        // }

                        return null;
                      },

                      items:
                          question.metaData.options?.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(
                                option,
                                style: TypographyApp.Body_mid_Mid.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_400,
                                ),
                              ),
                              alignment: Alignment.center,
                            );
                          }).toList() ??
                          [],
                      prefixIcon: IconApp.Status,
                      borderRadio: 16,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              } else if (question.type == "checkbox") {
                if (addAdsController.checkBoxAnswer[question.id] == null) {
                  addAdsController.checkBoxAnswer[question.id] = <String>[].obs;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          question.question,
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_600,
                          ),
                        ),
                        Text(
                          question.unitOfMeasurement == null
                              ? ""
                              : "(${question.unitOfMeasurement})",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_200,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      final selectedOptions =
                          addAdsController.checkBoxAnswer[question.id] ?? [];
                      return Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: List.generate(
                          question.metaData.options?.length ?? 0,
                          (indexOption) {
                            String optionValue =
                                question.metaData.options![indexOption];
                            return CheckboxListTile(
                              contentPadding: EdgeInsetsGeometry.zero,
                              title: Text(
                                question.metaData.options![indexOption],
                              ),
                              value: selectedOptions.contains(optionValue),
                              onChanged: (bool? value) {
                                value!
                                    ? addAdsController
                                          .checkBoxAnswer[question.id]
                                          ?.add(optionValue)
                                    : addAdsController
                                          .checkBoxAnswer[question.id]
                                          ?.remove(optionValue);
                                addAdsController.saveCheckBoxAnswer(
                                  question.id,
                                  addAdsController.checkBoxAnswer[question
                                          .id] ??
                                      [],
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ],
                );
              }
              else if (question.type == "radio") {
                String? savedValue = addAdsController.radioAnswer[question.id];
                if (savedValue == null &&
                    addAdsController.finalAnswers.containsKey(
                      "custom_fields[${question.id}]",
                    )) {
                  savedValue = addAdsController
                      .finalAnswers["custom_fields[${question.id}]"];
                  if (savedValue != null) {
                    addAdsController.radioAnswer[question.id] = savedValue;
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                    Text(
                      question.question,
                      style: TypographyApp.Title_Mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      question.unitOfMeasurement == null
                          ? ""
                          : "(${question.unitOfMeasurement})",
                      style: TypographyApp.Title_Mid_Regular.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_200,
                      ),
                    ),
                    //     if (question.metaData.is_required)
                    //       Text(" *", style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                    // const SizedBox(height: 8),
                    Obx(() {
                      String? currentValue =
                          addAdsController.radioAnswer[question.id];

                      return Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: List.generate(
                          question.metaData.options?.length ?? 0,
                          (indexOption) {
                            String optionValue =
                                question.metaData.options![indexOption];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<String>(
                                  value: optionValue,
                                  groupValue: currentValue,
                                  onChanged: (value) {
                                    if (value != null) {
                                      addAdsController.saveRadioAnswer(
                                        question.id,
                                        value,
                                      );
                                    }
                                  },
                                  activeColor:
                                      ThemeApp.Foundation_Main_main_500,
                                ),
                                Text(
                                  optionValue,
                                  style: TypographyApp.Body_mid_Regular,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                );
              } else if (question.type == "textarea") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    Text(
                      question.question,
                      style: TypographyApp.Title_Mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_600,
                      ),
                    ),
                    // if (question.metaData.is_required)
                    //   Text(" *", style: TextStyle(color: Colors.red)),
                    //   ],
                    // ),
                    const SizedBox(height: 5),
                    AppTextAreaWidget(
                      hintText: question.metaData.hint ?? question.question,
                      initialValue:
                          addAdsController
                              .finalAnswers["custom_fields[${question.id}]"] ??
                          "",
                      // controller: TextEditingController(
                      //   text:
                      //       addAdsController
                      //           .finalAnswers["custom_fields[${question.id}]"] ??
                      //       "",
                      // ),
                      validate: (value) =>
                          Validators.validateTextDinamckQuestion(
                            value,
                            question.question,
                            question.metaData.is_required,
                          ),
                      onChange: (value) {
                        addAdsController.saveSimpleAnswer(question.id, value);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }
            },
          );
        }
        return SizedBox();
      }
    });
  }
}
