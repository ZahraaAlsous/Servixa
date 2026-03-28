import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';

class ThirdStepBusinessAccountContactInformationScreen extends StatelessWidget {
  final TextEditingController addressDetailsController =
      TextEditingController();
  ThirdStepBusinessAccountContactInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "City",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppDropdownButtonFormFieldWidget(
          hintText: "City",
          onChanged: (value) {
            // addAdsController.typeService = value;
          },
          prefixIcon: IconApp.suggestion,
          borderRadio: 16,
          validator: Validators.validateReviewAndRequestOrder,
          items: [
            DropdownMenuItem<String>(
              value: "dolar",
              child: Text(
                "Dollar \$",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
              alignment: Alignment.center,
            ),

            DropdownMenuItem<String>(
              value: "sp",
              child: Text(
                "Sp Syrian pounds",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
              alignment: Alignment.center,
            ),
          ],
        ),

        const SizedBox(height: 10),
        Text(
          "Address Detail",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),

        AppTextAreaWidget(
          hintText: "Address Detail",
          prefixIcon: IconApp.Balconies,
          controller: addressDetailsController,
        ),
      ],
    );
  }
}
