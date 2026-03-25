import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';

class FiltterRadioWidget extends StatelessWidget {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  final String option;
  final AdType optionSelected;

  FiltterRadioWidget({
    super.key,
    required this.option,
    required this.optionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        width: size.width * 0.426,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(
            color: ThemeApp.Foundation_Secendary_grey_100,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          onTap: () {
            searchFilterController.selectedAdType.value = optionSelected;
            if (searchFilterController.EffectiveTypeFilter.value) {
              searchFilterController.applyFilters();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  option,
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_300,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          searchFilterController.selectedAdType.value ==
                              AdType.buying
                          ? ThemeApp.Foundation_Secendary_grey_400
                          : ThemeApp.Foundation_Secendary_grey_300,
                      width:
                          searchFilterController.selectedAdType.value ==
                              optionSelected
                          ? 5
                          : 1,
                    ),
                    color:
                        searchFilterController.selectedAdType.value ==
                            optionSelected
                        ? ThemeApp.Foundation_Main_main_400
                        : ThemeApp.whiteBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
