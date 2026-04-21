import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';

// class ThirdStepSupCategoryWidget extends StatelessWidget {
//   ThirdStepSupCategoryWidget({super.key});
//   CategoryController categoryController = Get.put(CategoryController());
//   AdsController adsController = Get.put(AdsController());
//   AddAdsController addAdsController = Get.put(AddAdsController());

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 1,
//         childAspectRatio: 120 / 91,
//       ),
//       itemCount: categoryController.subCategories.length,
//       itemBuilder: (context, indexCategory) {
//         SubCategoryModel subCategory =
//             categoryController.subCategories[indexCategory];
//         return HomeCardCategoryWidget(
//           assetName: subCategory.icon,
//           categoryName: subCategory.name,
//           CategoryId: subCategory.id,
//           enableSelection: true,
//           isThisCardSelect:
//               subCategory.id ==
//               addAdsController.selectedSubCategoryAds.value?.id,
//           onTap: () {
//             addAdsController.selectedSubCategoryAds.value = subCategory;
//           },
//         );
//       },
//     );
//   }
// }

class ThirdStepSupCategoryWidget extends StatelessWidget {
  ThirdStepSupCategoryWidget({super.key});

  // ✅ استخدام Get.find
  final CategoryController categoryController = Get.find();
  final AddAdsController addAdsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
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
          return AppCardCategoryWidget(
            assetName: subCategory.icon,
            categoryName: subCategory.name,
            CategoryId: subCategory.id,
            // enableSelection: true,
            // isThisCardSelect: subCategory.id == addAdsController.selectedSubCategoryAds.value?.id,
            // selectCategoryId: addAdsController.selectedSubCategoryAds.value?.id,
            onTap: () {
              addAdsController.selectedSubCategoryAds.value = subCategory;
            },
          );
        },
      ),
    );
  }
}
