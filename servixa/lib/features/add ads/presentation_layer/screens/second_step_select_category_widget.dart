import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';

class SecondStepSelectCategoryWidget extends StatelessWidget {
  SecondStepSelectCategoryWidget({super.key});

  final CategoryController categoryController = Get.find();
  final AddAdsController addAdsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
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
          return AppCardCategoryWidget(
            onTap: () {
              addAdsController.selectedCategoryAds.value = category;
            },
            assetName: category.icon,
            categoryName: category.name,
            CategoryId: category.id,
            // enableSelection: true,
            // isThisCardSelect: category.id == addAdsController.selectedCategoryAds.value?.id,
            // selectCategoryId: addAdsController.selectedCategoryAds.value?.id,
          );
        },
      );
    });
  }
}
