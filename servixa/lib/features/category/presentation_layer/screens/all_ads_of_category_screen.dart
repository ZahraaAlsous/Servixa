import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_search_text_form_field_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/search_filter/presentation_layer/screens/search_screen.dart';

class AllAdsOfCategoryScreen extends StatefulWidget {
  CategoryModel category;
  AllAdsOfCategoryScreen({super.key, required this.category});

  @override
  State<AllAdsOfCategoryScreen> createState() => _AllAdsOfCategoryScreenState();
}

class _AllAdsOfCategoryScreenState extends State<AllAdsOfCategoryScreen> {
  final RxInt crossAxisCount = 1.obs;
  final AdsController adsController = Get.put(AdsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      adsController.adsCategory.clear();
      adsController.getAds(categoryId: widget.category.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            AppRichTextWidget(
              // firstText: "Ads in ",
              // secondText: widget.category.name,
              firstText: widget.category.name,
              secondText:" ads",
              typographyApp: TypographyApp.Title_larg_Mid,
              colorFirstText: ThemeApp.Foundation_Main_main_500,
              colorSecondText: ThemeApp.black,
            ),
        
            Obx(() {
              if (adsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (adsController.adsCategory.isEmpty) {
                return Expanded(child: AppNothingWidget());
              }
              return Expanded(
                child: GridView.builder(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 10,
                  ),
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount.value,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: crossAxisCount.value == 1 ? 2.5 : 0.69,
                  ),
                  itemCount: adsController.adsCategory.length,
                  itemBuilder: (context, indexAds) {
                    return AppCardAdsWidget(
                      ads: adsController.adsCategory[indexAds],
                      widthCard: 0.431,
                      isGridView: crossAxisCount.value == 2,
                      isSearchCard: true,
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
