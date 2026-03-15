import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/home/presentation_layer/widgets/home_card_category_widget.dart';

class ThirdStepSupCategoryWidget extends StatelessWidget {
   ThirdStepSupCategoryWidget({super.key});
  CategoryController categoryController = Get.put(CategoryController());

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
      itemCount: categoryController.categories.length,
      itemBuilder: (context, indexCategory) {
        CategoryModel category = categoryController.categories[indexCategory];
        return HomeCardCategoryWidget(
          assetName: category.icon,
          categoryName: category.name,
        );
      },
    );
  }
}
