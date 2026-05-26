import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';

class ThirdStepSupCategoryWidget extends StatelessWidget {
  ThirdStepSupCategoryWidget({super.key});

  final CategoryController categoryController = Get.find();
  final AddAdsController addAdsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoadingSubCategory.value) {
        // return CircularProgressIndicator();
        return LoadingAnimationWidget(message: "Loading sup categories...".tr());
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
        itemCount: categoryController.subCategories.length,
        itemBuilder: (context, indexCategory) {
          final subCategory = categoryController.subCategories[indexCategory];
          return Obx(() {
            final isSelected = addAdsController.isSelected(
              subCategory,
              // addAdsController.selectedSubCategoryAds.value?.id ?? 0,
              addAdsController.selectedSubCategoryAdsId.value ?? 0,
            );
            return AppCardCategoryWidget(
              assetName: subCategory.icon,
              categoryName: subCategory.name,
              CategoryId: subCategory.id,
              colorCard: isSelected ? ThemeApp.Foundation_Main_main_200 : null,

              // enableSelection: true,
              // isThisCardSelect: subCategory.id == addAdsController.selectedSubCategoryAds.value?.id,
              // selectCategoryId: addAdsController.selectedSubCategoryAds.value?.id,
              onTap: () {
                addAdsController.selectedSubCategoryAds.value = subCategory;
                addAdsController.selectedSubCategoryAdsId.value =
                    subCategory.id;
              },
            );
          });
        },
      );
    });
  }
}
