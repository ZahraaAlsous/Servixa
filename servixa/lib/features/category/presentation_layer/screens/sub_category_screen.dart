import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/features/home/presentation_layer/widgets/home_card_category_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  int categoryId;
  SubCategoryScreen({super.key, required this.categoryId});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());
  @override
  void initState() {
    categoryController.getSubCategories(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              firstText: categoryController.titleCategory.value,
              secondText: " Categories",
              colorFirstText: ThemeApp.Foundation_Main_main_500,
              colorSecondText: ThemeApp.Foundation_Grey_grey_700,
              typographyApp: TypographyApp.Title_larg_Mid,
            ),
            SizedBox(height: DimensApp.spaceBetweenSection),
            AppSearchTextFormFieldWidget(radio: 16),
            SizedBox(height: DimensApp.spaceBetweenSection),
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 1,
                  childAspectRatio: 120 / 84,
                ),
                itemCount: categoryController.subCategories.length,
                itemBuilder: (context, indexSubCategory) {
                  SubCategoryModel subCategory =
                      categoryController.subCategories[indexSubCategory];
                  return HomeCardCategoryWidget(
                    assetName: subCategory.icon,
                    categoryName: subCategory.name,
                    typographyApp: TypographyApp.Label_Mid_Mid,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );

    ;
  }
}
