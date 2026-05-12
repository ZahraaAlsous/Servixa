import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this item",
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Main_Color_900,
            ),
          ),
          const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: ads.categoryQuestionAnswer!.map((answer) {
              if (answer.value == null) return const SizedBox();

              String displayValue = "";
              if (answer.value is List) {
                List listValue = answer.value as List;
                displayValue = listValue.join(", ");
              } else if (answer.value is String) {
                if (answer.value.toString().isEmpty) return const SizedBox();
                displayValue = answer.value;
              } else {
                displayValue = answer.value.toString();
              }

              return SizedBox(
                width: widthScreen * 0.4,
                child: Row(
                  children: [
                    // SvgPicture.asset(
                    //   _getIconForField(answer.question.type),
                    //   width: 22,
                    //   height: 22,
                    //   color: ThemeApp.Foundation_Main_main_500,
                    // ),
                    Text(
                      "${answer.question.question}: ",
                      style: TypographyApp.Title_Mid_Regular.copyWith(
                        color: ThemeApp.black,
                      ),
                    ),
                    Text(
                      displayValue,
                      style: TypographyApp.Title_Mid_Regular.copyWith(
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (answer.unit_of_masure != null &&
                        answer.unit_of_masure!.isNotEmpty)
                      Text(
                        " (${answer.unit_of_masure!})",
                        style: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Secendary_grey_400,
                        ),
                      ),
                  ],
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
