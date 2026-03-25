import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class SectionActiveFilterTitleWidget extends StatelessWidget {
  final RxBool value;
  final void Function(bool?)? onChanged;
  final String FilterName;
  const SectionActiveFilterTitleWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.FilterName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            // value: searchFilterController.EffectiveCategoryFilter.value,
            value: value.value,
            onChanged: onChanged,
            // (value) {
            // searchFilterController.activeFilter();
            // },
            activeColor: ThemeApp.Foundation_Statue_Green,
            checkColor: ThemeApp.secondaryButtonBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(
              width: 1.5,
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        // Text("Category"),
        Text(
          FilterName,
          style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
        ),
      ],
    );
  }
}
