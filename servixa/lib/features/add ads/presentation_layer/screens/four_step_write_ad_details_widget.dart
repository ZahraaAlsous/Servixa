import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_checkbox_terms_policies_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_ads_add_image_widget.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_ads_question_section.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_main_image_widget.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';

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
            validator: (value) =>
                Validators.validateNumber(value, "Price".tr()),
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
            value: addAdsController.typeService.value,
            onChanged: (value) {
              addAdsController.typeService.value = value;
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

          Obx(() {
            if (addAdsController.typeService.value == "2") {
              return Row(
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
              );
            }
            if (addAdsController.typeService.value == "1") {
              addAdsController.isRent.value = false;
            }
            return SizedBox.shrink();
          }),
          const SizedBox(height: 16),

          AddAdsQuestionSection(),

          AppCheckboxTermsPoliciesWidget(),
        ],
      ),
    );
  }
}
