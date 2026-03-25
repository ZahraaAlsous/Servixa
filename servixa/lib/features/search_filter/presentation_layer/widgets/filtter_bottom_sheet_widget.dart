import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';
import 'package:servixa/features/search_filter/presentation_layer/widgets/filtter_radio_widget.dart';
import 'package:servixa/features/search_filter/presentation_layer/widgets/section_active_filter_title_widget.dart';

class FiltterBottomSheetWidget extends StatelessWidget {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  final CategoryController categoryController = Get.put(CategoryController());
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FiltterBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FractionallySizedBox(
      heightFactor: 0.87,
      child: SingleChildScrollView(
        // child: Form(
        //   key: _formKey,
        child: Container(
          padding: EdgeInsetsGeometry.all(8),
          decoration: BoxDecoration(
            color: ThemeApp.whiteBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "      Filters",
                      style: TypographyApp.Title_larg_Mid.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_700,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      // edit
                      onPressed: searchFilterController
                          .resetSearchFilterToInitialState,
                      child: Text(
                        "Reset",
                        style: TypographyApp.Title_Mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                      ),
                    ),
                  ],
                ),
                SectionActiveFilterTitleWidget(
                  value: searchFilterController.EffectiveLocationFilter,
                  onChanged: (value) {
                    searchFilterController.activeLocationFilter();
                  },
                  FilterName: "Location",
                ),
                AppOutlinedButtonWidget(
                  textContent: "Add Location",
                  icon: IconApp.place,
                  // edit
                  onPressed: () {},
                ),
                SizedBox(height: 5),

                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SectionActiveFilterTitleWidget(
                              value: searchFilterController
                                  .EffectiveCategoryFilter,
                              onChanged: (value) {
                                searchFilterController.activeCategoryFilter();
                              },
                              FilterName: "Category",
                            ),

                            // AppDropdownButtonFormFieldWidget(
                            //   hintText: "All In Classified",
                            //   value:
                            //       searchFilterController
                            //           .selectCategory
                            //           .value
                            //           .isNotEmpty
                            //       ? searchFilterController.selectCategory.value
                            //       : null,
                            //   onChanged: (value) {
                            //     if (value != null && value is CategoryModel) {
                            //       searchFilterController.selectCategory.value =
                            //           value.name;
                            //       // searchFilterController.selectedCategoryId.value = value.id;
                            //       categoryController.getSubCategories(value.id);
                            //       log(
                            //         'Selected category: ${value.name}, ID: ${value.id}',
                            //       );
                            //     }
                            //   },
                            //   // value: searchFilterController.selectCategory.value,
                            //   // onChanged: (value) {
                            //   //   searchFilterController.selectCategory.value =
                            //   //       value.toString();
                            //   //   categoryController.getSubCategories(value!.id);
                            //   //   log(
                            //   //     searchFilterController.selectCategory.value,
                            //   //   );

                            //   //   if (value != null && value is CategoryModel) {
                            //   //   searchFilterController.selectCategory.value =
                            //   //       value.name;
                            //   //   categoryController.getSubCategories(value.id);
                            //   //   log(
                            //   //     searchFilterController.selectCategory.value,
                            //   //   );
                            //   // }
                            //   // },
                            //   items: categoryController.categories.map((
                            //     category,
                            //   ) {
                            //     return DropdownMenuItem<CategoryModel>(
                            //       value: category,
                            //       child: Text(category.name),
                            //     );
                            //   }).toList(),

                            //   prefixIcon: IconApp.category,
                            //   borderRadio: 16,
                            // ),
                            AppDropdownButtonFormFieldWidget(
                              hintText: "All In Classified",
                              value:
                                  searchFilterController
                                      .selectCategory
                                      .value
                                      .isNotEmpty
                                  ? categoryController.categories.firstWhere(
                                      (category) =>
                                          category.name ==
                                          searchFilterController
                                              .selectCategory
                                              .value,
                                      // orElse: () =>
                                      //     CategoryModel(id: 0, name: ""),
                                    )
                                  : null,
                              onChanged: (value) {
                                if (value != null && value is CategoryModel) {
                                  searchFilterController.selectCategory.value =
                                      value.name;
                                  searchFilterController
                                          .selectCategoryIcon
                                          .value =
                                      value.icon;
                                  categoryController.getSubCategories(value.id);
                                  log(
                                    'Selected category: ${value.name}, ID: ${value.id}',
                                  );
                                }
                              },
                              items: categoryController.categories.map((
                                category,
                              ) {
                                return DropdownMenuItem<CategoryModel>(
                                  value: category,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(category.icon),
                                      // edit
                                      // design
                                      Text(category.name),
                                    ],
                                  ),
                                );
                              }).toList(),
                              // prefixIcon: IconApp.category,
                              isChanged: Obx(() {
                                if (searchFilterController
                                    .selectCategoryIcon
                                    .value
                                    .isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      searchFilterController
                                          .selectCategoryIcon
                                          .value,
                                      width: 20,
                                      height: 20,
                                      colorFilter: const ColorFilter.mode(
                                        ThemeApp.Foundation_Main_main_500,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    IconApp.category,
                                    // size: 20,
                                    color: ThemeApp.Foundation_Main_main_500,
                                  ),
                                );
                              }),
                              borderRadio: 16,
                            ),
                          ],
                        ),
                      ),

                      // if (searchFilterController
                      //         .selectCategory
                      //         .value
                      //         .isNotEmpty &&
                      //     categoryController.subCategories.value.isNotEmpty)
                      //   Expanded(
                      //     child: Column(
                      //       children: [
                      //         SectionActiveFilterTitleWidget(
                      //           value: searchFilterController
                      //               .EffectiveSubCategoryFilter,
                      //           onChanged: (value) {
                      //             searchFilterController
                      //                 .activeSubCategoryFilter();
                      //           },
                      //           FilterName: "Sub Category",
                      //         ),

                      //         AppDropdownButtonFormFieldWidget(
                      //           hintText: "All In Classified",
                      //           onChanged: (value) {
                      //             searchFilterController.selectCategory.value =
                      //                 value.toString();
                      //           },
                      //           items: categoryController.subCategories.map((
                      //             subCategory,
                      //           ) {
                      //             return DropdownMenuItem<String>(
                      //               value: subCategory.name,
                      //               child: Text(subCategory.name),
                      //             );
                      //           }).toList(),

                      //           prefixIcon: IconApp.category,
                      //           borderRadio: 16,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      if (searchFilterController
                              .selectCategory
                              .value
                              .isNotEmpty &&
                          categoryController.subCategories.isNotEmpty)
                        Expanded(
                          child: Column(
                            children: [
                              SectionActiveFilterTitleWidget(
                                value: searchFilterController
                                    .EffectiveSubCategoryFilter,
                                onChanged: (value) {
                                  searchFilterController
                                      .activeSubCategoryFilter();
                                },
                                FilterName: "Sub Category",
                              ),
                              Obx(
                                () => AppDropdownButtonFormFieldWidget(
                                  hintText: "All In Classified",
                                  value:
                                      searchFilterController
                                          .selectSubCategory
                                          .value
                                          .isEmpty
                                      ? null
                                      : searchFilterController
                                            .selectSubCategory
                                            .value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      searchFilterController
                                          .selectSubCategory
                                          .value = value
                                          .toString();
                                      log(
                                        'Selected sub category: ${value.toString()}',
                                      );
                                    }
                                  },
                                  items: categoryController.subCategories.map((
                                    subCategory,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: subCategory.name,
                                      child: Row(
                                        children: [
                                          // edit
                                          // disen
                                          SvgPicture.asset(subCategory.icon),
                                          Text(subCategory.name),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  prefixIcon: IconApp.category,
                                  borderRadio: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 5),

                SectionActiveFilterTitleWidget(
                  value: searchFilterController.EffectiveBudgetFilter,
                  onChanged: (value) {
                    searchFilterController.activeBudgetFilter();
                  },
                  FilterName: "Budget (Price)",
                ),

                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        hintText: "Min",
                        // edit
                        icon: IconApp.solarTagPriceOutline,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          searchFilterController.minPriceFilter.value =
                              int.tryParse(value);
                        },
                        controller: searchFilterController.minPriceController,
                        // controller: searchFilterController.minPriceController,
                        validator: (value) => Validators.validateMinPrice(
                          // minPriceController.text,
                          value,
                          searchFilterController,
                        ),
                      ),
                    ),
                    // Expanded(child: s),
                    SizedBox(width: 20),
                    Expanded(
                      child: AppTextFormField(
                        hintText: "Max",
                        // edit
                        icon: IconApp.solarTagPriceOutline,
                        sizeIconPrefix: 18,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          searchFilterController.maxPriceFilter.value =
                              int.tryParse(value);
                          // _formKey.currentState?.validate();
                        },
                        controller: searchFilterController.maxPriceController,
                        // controller: searchFilterController.maxPriceController,
                        validator: (value) => Validators.validateMaxPrice(
                          // maxPriceController.text,
                          value,
                          searchFilterController,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5),

                SectionActiveFilterTitleWidget(
                  value: searchFilterController.EffectiveTypeFilter,
                  onChanged: (value) {
                    searchFilterController.activeTypeFilter();
                  },
                  FilterName: "Ad Type",
                ),

                Row(
                  children: [
                    Expanded(
                      child: FiltterRadioWidget(
                        option: 'Buying',
                        optionSelected: AdType.buying,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FiltterRadioWidget(
                        option: "Selling",
                        optionSelected: AdType.selling,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),

                SectionActiveFilterTitleWidget(
                  value: searchFilterController.EffectivePostedFilter,
                  onChanged: (value) {
                    searchFilterController.activePostedFilter();
                  },
                  FilterName: "Posted Since",
                ),
                AppDropdownButtonFormFieldWidget(
                  hintText: "All in Time ",
                  onChanged: (value) {
                    if (value != null) {
                      searchFilterController.selectPosted.value = value
                          .toString();
                    }
                  },
                  // edit
                  items: [],
                  // edit
                  prefixIcon: IconApp.clarityDateLine,
                  borderRadio: 16,
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: size.width * 0.927,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        searchFilterController.applyFilters();
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.Foundation_Main_main_400,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        "Apply Filters${searchFilterController.numberOfEffectiveFilters() > 0 ? " (${searchFilterController.numberOfEffectiveFilters()})" : ""}",
                        style: TypographyApp.Title_Mid_Mid.copyWith(
                          color: ThemeApp.whiteBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
