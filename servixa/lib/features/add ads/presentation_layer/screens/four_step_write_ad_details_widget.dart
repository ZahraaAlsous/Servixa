import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_checkbox_terms_policies_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_ads_add_image_widget.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_main_image_widget.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';

class FourStepWriteAdDetailsWidget extends StatefulWidget {
  FourStepWriteAdDetailsWidget({super.key});

  @override
  State<FourStepWriteAdDetailsWidget> createState() =>
      _FourStepWriteAdDetailsWidgetState();
}

class _FourStepWriteAdDetailsWidgetState
    extends State<FourStepWriteAdDetailsWidget> {
  AdsController adsController = Get.put(AdsController());
  AddAdsController addAdsController = Get.put(AddAdsController());
  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addAdsController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ad Title".tr(),
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          const SizedBox(height: 5),

          AppTextFormField(
            hintText: "Title..",
            icon: IconApp.tags,
            // textInputAction:,
            controller: addAdsController.titleController,
            validator: Validators.validateReviewAndRequestOrder,
            // onChanged: (value) {
            //   addAdsController.adTitle = value;
            // },
          ),

          const SizedBox(height: 16),

          // Text(
          //   "Ad Slug",
          //   style: TypographyApp.Title_Mid_Mid.copyWith(
          //     color: ThemeApp.Foundation_Secendary_grey_600,
          //   ),
          // ),
          // const SizedBox(height: 5),

          // AppTextFormField(
          //   hintText: "Slug..",
          //   icon: IconApp.solarLinkOutline,
          //   controller: slugController,
          //   onChanged: (value) {
          //     addAdsController.adSlug = value;
          //   },
          //   validator: Validators.validateReviewAndRequestOrder,
          // ),

          // const SizedBox(height: 16),
          Text(
            "Description".tr(),
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          const SizedBox(height: 5),

          AppTextAreaWidget(
            hintText: "Description..",
            prefixIcon: IconApp.description,
            // onChange: (value) {
            //   addAdsController.adDescription = value;
            // },
            controller: addAdsController.descriptionController,
            validate: Validators.validateReviewAndRequestOrder,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: addAdsController.isRent.value,
                  onChanged: (value) {
                    // addAdsController.isRent.value = value!;
                    addAdsController.isRent.value =
                        !addAdsController.isRent.value;
                  },
                ),
              ),
              Text(
                "Is it for rent ?".tr(),
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          AddMainImageWidget(title: "Main Picture"),

          const SizedBox(height: 16),
          AddAdsAddImageWidget(
            list: addAdsController.listSelectedSubImage,
            buttonContain: "Add Sub Picture",
          ),
          const SizedBox(height: 16),

          Text(
            "Price".tr(),
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          const SizedBox(height: 5),

          AppTextFormField(
            hintText: "Price..",
            icon: IconApp.price,
            keyboardType: TextInputType.number,
            controller: addAdsController.priceController,
            validator: (value) => Validators.validateNumber(value, "Price".tr()),
            // onChanged: (value) {
            //   addAdsController.price.value = value;
            // },
          ),

          const SizedBox(height: 16),

          Text(
            "Currency type".tr(),
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          const SizedBox(height: 5),

          AppDropdownButtonFormFieldWidget(
            hintText: "Fixed",
            value: addAdsController.typeCoin,
            onChanged: (value) {
              addAdsController.typeCoin = value;
            },
            prefixIcon: IconApp.price,
            borderRadio: 16,
            validator: Validators.validateReviewAndRequestOrder,
            items: [
              DropdownMenuItem<String>(
                value: "1",
                child: Text(
                  "SYP".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
                alignment: Alignment.center,
              ),
              DropdownMenuItem<String>(
                value: "2",
                child: Text(
                  "USD".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            "Type".tr(),
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          const SizedBox(height: 5),
          AppDropdownButtonFormFieldWidget(
            hintText: "Service Request",
            value: addAdsController.typeService,
            onChanged: (value) {
              addAdsController.typeService = value;
            },
            prefixIcon: IconApp.suggestion,
            borderRadio: 4,
            validator: Validators.validateReviewAndRequestOrder,
            items: [
              DropdownMenuItem<String>(
                value: "1",
                child: Text(
                  "Service".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
                alignment: Alignment.center,
              ),

              DropdownMenuItem<String>(
                value: "2",
                child: Text(
                  "Equipment".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // if (addAdsController.selectedCategoryAds.value?.questions != null &&
          //     addAdsController.selectedCategoryAds.value!.questions!.isNotEmpty)
          Obx(() {
            if (categoryController.isLoadingCategoryQuestions.value) {
              // return Center(child: CircularProgressIndicator());
              return LoadingAnimationWidget(
                message: "Loading dynamic questions...".tr(),
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
                            hintText:
                                question.metaData.hint ?? question.question,
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
                              addAdsController.saveSimpleAnswer(
                                question.id,
                                value,
                              );
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
                            hintText:
                                question.metaData.hint ?? question.question,
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
                              addAdsController.saveSimpleAnswer(
                                question.id,
                                value,
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                        ],
                      );
                    } else if (question.type == "dropdown") {
                      // AddAdsDropdownButtonFormFieldWidget(items: [],)

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
                            initialValue:
                                addAdsController
                                    .finalAnswers["custom_fields[${question.id}]"] ??
                                null,
                            // edit
                            onChanged: (value) {},
                            items:
                                question.options?.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(
                                      option,
                                      style:
                                          TypographyApp.Body_mid_Mid.copyWith(
                                            color: ThemeApp
                                                .Foundation_Secendary_grey_400,
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
                                  var isChecked =
                                      addAdsController.checkboxStates[question
                                          .id]![indexOption];

                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          addAdsController
                                                  .checkboxStates[question
                                                  .id]![indexOption] =
                                              value!;
                                        },
                                      ),
                                      Text(
                                        question.metaData.options![indexOption],
                                      ),
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
          }),

          AppCheckboxTermsPoliciesWidget(),
        ],
      ),
    );
  }
}
