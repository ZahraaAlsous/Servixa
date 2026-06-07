import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
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
          onPressed: () {
            categoryController.getCategoryQuestions(
              addAdsController.selectedSubCategoryAds.value != null
                  ? addAdsController.selectedSubCategoryAds.value!.id
                  : addAdsController.selectedCategoryAds.value!.id,
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
                      validator: (value) =>
                          Validators.validateTextDinamckQuestion(
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
                 // الحصول على القيمة المحفوظة
                String? savedValue = addAdsController
                    .finalAnswers["custom_fields[${question.id}]"];

                // الحصول على قائمة الخيارات
                List<String> options = question.metaData.options ?? [];

                // التحقق مما إذا كانت القيمة المحفوظة موجودة في الخيارات
                String? validValue =
                    (savedValue != null && options.contains(savedValue))
                    ? savedValue
                    : null;

                // للتصحيح: طباعة القيم للتأكد
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
                addAdsController.initializeCheckboxes(
                  question.id,
                  question.metaData.options?.length ?? 0,
                );

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
                    Wrap(
                      children: List.generate(
                        question.metaData.options?.length ?? 0,
                        (indexOption) {
                          return Obx(() {
                            var isChecked = addAdsController
                                .checkboxStates[question.id]![indexOption];

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    addAdsController.checkboxStates[question
                                            .id]![indexOption] =
                                        value!;
                                  },
                                ),
                                Text(question.metaData.options![indexOption]),
                              ],
                            );
                          });
                        },
                      ),
                    ),
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
