import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';
import 'package:servixa/features/search_filter/presentation_layer/widgets/filtter_bottom_sheet_widget.dart';

enum SingingCharacter { lafayette, jefferson }

class SearchScreen extends StatelessWidget {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  final CategoryController categoryController = Get.put(CategoryController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppSearchTextFormFieldWidget(
                onChanged: searchFilterController.onSearchChanged,
                onPressed: () {
                  Get.bottomSheet(
                    isDismissible: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    FiltterBottomSheetWidget(),
                  );
                },
                onFieldSubmitted: (value) {
                  searchFilterController.filterSearch.value = value;
                  searchFilterController.applyFilters();
                },
              ),
            ),
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
            Obx(
              () => Text(
                searchFilterController.isDisplayTitleSearchResults()
                    ? "Searched items"
                    : "Popular Ads",
                style: TypographyApp.title_Sections.copyWith(
                  color: ThemeApp.Foundation_Main_Color_900,
                ),
              ),
            ),
            const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
            Center(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: searchFilterController.adsSearchList.length,
                  itemBuilder: (context, indexAds) {
                    AdsModel ads =
                        searchFilterController.adsSearchList[indexAds];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: AppCardAdsWidget(
                        ads: ads,
                        widthCard: 0.9139,
                        isGridView: false,
                        isSearchCard: true,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
