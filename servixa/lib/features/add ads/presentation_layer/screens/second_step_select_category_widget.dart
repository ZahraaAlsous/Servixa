import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/home/presentation_layer/widgets/home_card_category_widget.dart';

// class SecondStepSelectCategoryWidget extends StatelessWidget {
//   SecondStepSelectCategoryWidget({super.key});
//   CategoryController categoryController = Get.put(CategoryController());
//   AdsController adsController = Get.put(AdsController());
//   AddAdsController addAdsController = Get.put(AddAdsController());

//   @override
//   Widget build(BuildContext context) {
//     return

//     GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 1,
//         // childAspectRatio: 120 / 84,
//         childAspectRatio: 120 / 91,
//       ),
//       itemCount: categoryController.categories.length,
//       itemBuilder: (context, indexCategory) {
//         CategoryModel category = categoryController.categories[indexCategory];
//         return HomeCardCategoryWidget(
//           onTap: () {
//             addAdsController.selectedCategoryAds.value = category;
//           },
//           assetName: category.icon,
//           categoryName: category.name,
//           CategoryId: category.id,
//           enableSelection: true,
//           isThisCardSelect:
//               category.id == addAdsController.selectedCategoryAds.value?.id,
//         );
//       },
//     );

//   }
// }

class SecondStepSelectCategoryWidget extends StatelessWidget {
  SecondStepSelectCategoryWidget({super.key});

  // ✅ استخدام Get.find
  final CategoryController categoryController = Get.find();
  final AddAdsController addAdsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        // ✅ Obx هنا
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
          return HomeCardCategoryWidget(
            onTap: () {
              addAdsController.selectedCategoryAds.value = category;
            },
            assetName: category.icon!,
            categoryName: category.name,
            CategoryId: category.id,
            // enableSelection: true,
            // isThisCardSelect: category.id == addAdsController.selectedCategoryAds.value?.id, // ✅ أو حذفها
            // selectCategoryId: addAdsController.selectedCategoryAds.value?.id,
          );
        },
      ),
    );
  }
}
