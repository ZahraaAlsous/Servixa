import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class QuestionDynamicSection extends StatelessWidget {
  final AdsModel ads;
  QuestionDynamicSection({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    final widthScreen = Get.width;

    final validAnswers = ads.categoryQuestionAnswer!.where((answer) {
      if (answer.value == null) return false;
      if (answer.value is String && answer.value.toString().isEmpty)
        return false;
      if (answer.value is List && (answer.value as List).isEmpty)
        return false;
      return true;
    }).toList();

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this item".tr(),
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Main_Color_900,
            ),
          ),
          const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

          Wrap(
            spacing: 10,
            runSpacing:
                14,
            children: validAnswers.map((answer) {
              String displayValue = "";
              if (answer.value is List) {
                List listValue = answer.value as List;
                displayValue = listValue.join(", ");
              } else {
                displayValue = answer.value.toString();
              }

              return SizedBox(
                width:
                    (widthScreen -
                        (widthScreen * DimensApp.spaceHorizontalScreen * 2) -
                        16) /
                    2,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${answer.question.question}: ",
                        style: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.black,
                        ),
                      ),
                      TextSpan(
                        text: displayValue,
                        style: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                      ),
                      if (answer.unit_of_masure != null &&
                          answer.unit_of_masure!.isNotEmpty)
                        TextSpan(
                          text: " (${answer.unit_of_masure!})",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_400,
                          ),
                        ),
                    ],
                  ),
                  softWrap:
                      true,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
        ],
      ),
    );
  }
}
