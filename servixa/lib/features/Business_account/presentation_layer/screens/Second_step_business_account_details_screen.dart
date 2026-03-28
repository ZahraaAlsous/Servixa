import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class SecondStepBusinessAccountDetailsScreen extends StatelessWidget {
  final TextEditingController activityController = TextEditingController();
  SecondStepBusinessAccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Column(
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
          // validator: ,
          // controller: ,
        ),
        SizedBox(height: 10),
        Text(
          "Business name (Arabic)",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextFormField(
          hintText: "name..",
          icon: IconApp.business,
          // validator: ,
          // controller: ,
        ),
        SizedBox(height: 10),

        Text(
          "Business name (English)",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextFormField(
          hintText: "name..",
          icon: IconApp.business,
          // validator: ,
          // controller: ,
        ),
        SizedBox(height: 10),

        Text(
          "Activities",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextAreaWidget(
          hintText: "Description..",
          prefixIcon: IconApp.business,
          controller: activityController,
        ),
        SizedBox(height: 10),

        Text(
          "Details",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextAreaWidget(
          hintText: "Description..",
          prefixIcon: IconApp.business,
          controller: activityController,
        ),
      ],
    );
  }
}
