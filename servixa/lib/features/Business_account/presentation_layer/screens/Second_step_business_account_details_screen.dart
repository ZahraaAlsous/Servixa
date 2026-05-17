import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

class SecondStepBusinessAccountDetailsScreen extends StatelessWidget {
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  SecondStepBusinessAccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: businessAccountController.formKeys[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "License number",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          AppTextFormField(
            hintText: "License number..",
            icon: IconApp.Balconies,
            keyboardType: TextInputType.number,
            validator: (value) =>
                Validators.validateNumber(value, "License number"),
            controller: businessAccountController.licenseNumberController,
          ),
          const SizedBox(height: 10),
          Text(
            "Business name (Arabic)",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          AppTextFormField(
            hintText: "name..",
            icon: IconApp.business,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF\s]+')),
            ],
            textDirection: TextDirection.rtl,
            validator: (value) =>
                Validators.validateNameArabic(value, "Business name (Arabic)"),
            controller: businessAccountController.businessNameArController,
          ),
          const SizedBox(height: 10),

          Text(
            "Business name (English)",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          AppTextFormField(
            hintText: "name..",
            icon: IconApp.business,
            inputFormatters: [
              // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
            ],
            textDirection: TextDirection.ltr,
            validator: (value) => Validators.validateNameEnglish(
              value,
              "Business name (English)",
            ),
            controller: businessAccountController.businessNameEnController,
          ),
          const SizedBox(height: 10),

          Text(
            "Activities",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          AppTextAreaWidget(
            hintText: "Description..",
            prefixIcon: IconApp.business,
            controller: businessAccountController.activityController,
            validate: Validators.validateReviewAndRequestOrder,
          ),
          const SizedBox(height: 10),

          Text(
            "Details",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          AppTextAreaWidget(
            hintText: "Description..",
            prefixIcon: IconApp.business,
            controller: businessAccountController.descriptionController,
            textInputAction: TextInputAction.done,
                        validate: Validators.validateReviewAndRequestOrder,

          ),
        ],
      ),
    );
  }
}
