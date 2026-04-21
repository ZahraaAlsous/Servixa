import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/presentation_layer/screens/sub_category_screen.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    categoryController.getCategories(AppSnackbar.showError);
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: ThemeApp.whiteBackground,
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRichTextWidget(
              firstText: "View All ",
              secondText: "Categories",
              typographyApp: TypographyApp.Title_larg_Mid,
            ),
            const SizedBox(height: DimensApp.spaceBetweenSection),
            AppSearchTextFormFieldWidget(radio: 16),
            const SizedBox(height: DimensApp.spaceBetweenSection),
            Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 1,
                  childAspectRatio: 120 / 84,
                ),
                itemCount: categoryController.categories.length,
                itemBuilder: (context, indexCategory) {
                  CategoryModel category =
                      categoryController.categories[indexCategory];
                  return AppCardCategoryWidget(
                    assetName: category.icon,
                    categoryName: category.name,
                    CategoryId: category.id,
                    onTap: () {
                      Get.to(SubCategoryScreen(categoryId: category.id));
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
