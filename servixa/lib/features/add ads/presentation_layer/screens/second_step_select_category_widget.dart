import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';

class SecondStepSelectCategoryWidget extends StatelessWidget {
  SecondStepSelectCategoryWidget({super.key});

  final CategoryController categoryController = Get.find();
  final AddAdsController addAdsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoadingCategory.value) {
        // return Center(child: CircularProgressIndicator());
        return LoadingAnimationWidget(message: "Loading categories...".tr());
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 1,
          childAspectRatio: 120 / 91,
        ),
        itemCount: categoryController.categories.length,
        itemBuilder: (context, indexCategory) {
          final category = categoryController.categories[indexCategory];

          return Obx(() {
            final isSelected = addAdsController.isSelected(
              category,
              // addAdsController.selectedCategoryAds.value?.id ?? 0,
              addAdsController.selectedCategoryAdsId.value ?? 0,
            );
            return AppCardCategoryWidget(
              onTap: () {
                addAdsController.selectedCategoryAdsId.value = category.id;
                addAdsController.selectedCategoryAds.value = category;
              },
              colorCard: isSelected ? ThemeApp.Foundation_Main_main_200 : null,
              assetName: category.icon,
              categoryName: category.name,
              CategoryId: category.id,
              // enableSelection: true,
              // isThisCardSelect: category.id == addAdsController.selectedCategoryAds.value?.id,
              // selectCategoryId: addAdsController.selectedCategoryAds.value?.id,
            );
          });
        },
      );
    });
  }
}
