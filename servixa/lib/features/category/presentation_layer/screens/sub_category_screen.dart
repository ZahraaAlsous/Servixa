import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/common/widgets/app_card_category_widget.dart';
import 'package:servixa/features/category/presentation_layer/screens/all_ads_of_category_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  CategoryModel category;
  SubCategoryScreen({super.key, required this.category});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());
  @override
  void initState() {
    categoryController.getSubCategories(widget.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: ThemeApp.whiteBackground,
      body:
          // SingleChildScrollView(
          //   padding: EdgeInsetsGeometry.symmetric(
          //     horizontal: size.width * DimensApp.spaceHorizontalScreen,
          //   ),
          //   child:
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: size.width * DimensApp.spaceHorizontalScreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRichTextWidget(
                  firstText: widget.category.name,
                  secondText: " Sub Categories",
                  typographyApp: TypographyApp.Title_larg_Mid,
                  colorFirstText: ThemeApp.Foundation_Main_main_500,
                  colorSecondText: ThemeApp.black,
                ),
                SizedBox(height: DimensApp.spaceBetweenSection),
                // AppSearchTextFormFieldWidget(radio: 16),
                // SizedBox(height: DimensApp.spaceBetweenSection),
                Obx(() {
                  if (categoryController.isLoadingSubCategory.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Expanded(
                    child: GridView.builder(
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 1,
                        childAspectRatio: 120 / 84,
                      ),
                      itemCount: categoryController.subCategories.length,
                      itemBuilder: (context, indexSubCategory) {
                        CategoryModel subCategory =
                            categoryController.subCategories[indexSubCategory];
                        return AppCardCategoryWidget(
                          assetName: subCategory.icon,
                          categoryName: subCategory.name,
                          CategoryId: subCategory.id,
                          typographyApp: TypographyApp.Label_Mid_Mid,
                          onTap: () {
                            Get.to(
                              () => AllAdsOfCategoryScreen(category: subCategory),
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

      // ),
    );
  }
}
