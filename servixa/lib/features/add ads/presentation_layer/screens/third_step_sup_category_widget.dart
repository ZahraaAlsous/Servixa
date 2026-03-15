import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/features/home/presentation_layer/widgets/home_card_category_widget.dart';

class ThirdStepSupCategoryWidget extends StatelessWidget {
  ThirdStepSupCategoryWidget({super.key});
  CategoryController categoryController = Get.put(CategoryController());
  AdsController adsController = Get.put(AdsController());
  AddAdsController addAdsController = Get.put(AddAdsController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 1,
        childAspectRatio: 120 / 84,
      ),
      itemCount: categoryController.subCategories.length,
      itemBuilder: (context, indexCategory) {
        SubCategoryModel subCategory =
            categoryController.subCategories[indexCategory];
        return HomeCardCategoryWidget(
          assetName: subCategory.icon,
          categoryName: subCategory.name,
          onTap: () {
            addAdsController.selectedSubCategoryAds.value = subCategory;
          },
        );
      },
    );
  }
}
