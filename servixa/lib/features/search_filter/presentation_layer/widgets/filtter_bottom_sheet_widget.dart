import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
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
      // heightFactor: 0.80,
      heightFactor: 0.695,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        // child: Form(
        //   key: _formKey,
        children: [
          Container(
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
                        "      Filters".tr(),
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
                          "Reset".tr(),
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // SectionActiveFilterTitleWidget(
                  //   value: searchFilterController.EffectiveLocationFilter,
                  //   onChanged: (value) {
                  //     searchFilterController.activeLocationFilter();
                  //   },
                  //   FilterName: "Location",
                  // ),
                  // AppOutlinedButtonWidget(
                  //   textContent: "Add Location",
                  //   icon: IconApp.place,
                  //   // edit
                  //   onPressed: () {},
                  // ),
                  // const SizedBox(height: 5),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          // flex: 5,
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
                              AppDropdownButtonFormFieldWidget(
                                hintText:
                                    categoryController.isLoadingCategory.value
                                    ? "Loading..."
                                    : "All In Classified",
                                value:
                                    searchFilterController.selectCategory.value,
                                // edit
                                onChanged:
                                    categoryController.isLoadingCategory.value
                                    ? null
                                    : (value) {
                                        if (value is CategoryModel) {
                                          searchFilterController
                                                  .selectSubCategory
                                                  .value =
                                              null;

                                          searchFilterController
                                                  .selectCategory
                                                  .value =
                                              value;
                                          if (searchFilterController
                                              .selectCategory
                                              .value!
                                              .hasChildren) {
                                            categoryController.getSubCategories(
                                              searchFilterController
                                                  .selectCategory
                                                  .value!
                                                  .id,
                                            );
                                          } else {
                                            searchFilterController
                                                    .selectSubCategory
                                                    .value =
                                                null;
                                            searchFilterController
                                                    .EffectiveSubCategoryFilter
                                                    .value =
                                                false;
                                          }
                                        }
                                      },
                                isSizeFontSmall:
                                    searchFilterController
                                            .selectCategory
                                            .value !=
                                        null &&
                                    searchFilterController
                                        .selectCategory
                                        .value!
                                        .hasChildren,
                                items: categoryController.categories.map((
                                  category,
                                ) {
                                  return DropdownMenuItem<CategoryModel>(
                                    value: category,
                                    child:
                                        // Row(
                                        //   children: [
                                        // SvgPicture.asset(category.icon!),
                                        // // edit
                                        // // design
                                        // Expanded(
                                        // child:
                                        Text(
                                          category.name,
                                          // edit
                                          style:
                                              TypographyApp
                                                  .Body_mid_Regular.copyWith(
                                                color: ThemeApp
                                                    .Foundation_Secendary_grey_700,
                                              ),
                                        ),
                                    // ),
                                    //   ],
                                    // ),
                                  );
                                }).toList(),
                                borderRadio: 16,
                                prefixIcon: IconApp.category,
                              ),
                            ],
                          ),
                        ),
                        if (searchFilterController.selectCategory.value !=
                                null &&
                            searchFilterController
                                .selectCategory
                                .value!
                                .hasChildren)
                          const SizedBox(width: 5),
                        if (searchFilterController.selectCategory.value !=
                                null &&
                            searchFilterController
                                .selectCategory
                                .value!
                                .hasChildren)
                          Expanded(
                            // flex: 5,
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
                                AppDropdownButtonFormFieldWidget(
                                  hintText:
                                      categoryController
                                          .isLoadingSubCategory
                                          .value
                                      ? "Loading..."
                                      : "All In Classified",
                                  value: searchFilterController
                                      .selectSubCategory
                                      .value,
                                  onChanged:
                                      categoryController
                                          .isLoadingSubCategory
                                          .value
                                      ? null
                                      : (Value) {
                                          if (Value is CategoryModel) {
                                            searchFilterController
                                                    .selectSubCategory
                                                    .value =
                                                Value;
                                          }
                                        },
                                  validator: (value) {
                                    if (searchFilterController
                                        .EffectiveCategoryFilter
                                        .value) {
                                      if (value == null) {
                                        return "pleas select sup category".tr();
                                      }
                                      if (!searchFilterController
                                          .EffectiveSubCategoryFilter
                                          .value) {
                                        return "pleas active sub category filter"
                                            .tr();
                                      }
                                    }
                                    return null;
                                  },
                                  items: categoryController.subCategories.map((
                                    subCategory,
                                  ) {
                                    return DropdownMenuItem<CategoryModel>(
                                      value: subCategory,
                                      child:
                                          // Row(
                                          //   children: [
                                          // edit
                                          // disen
                                          // SvgPicture.asset(subCategory.icon),
                                          // Expanded(
                                          //   child:
                                          Text(
                                            subCategory.name,
                                            // edit
                                            style: 
                                            // TextStyle(
                                            //   fontSize: 9,
                                            //   // overflow: TextOverflow.ellipsis
                                            // ),
                                            TypographyApp
                                                    .Body_mid_Regular.copyWith(
                                                  color: ThemeApp
                                                      .Foundation_Secendary_grey_700,
                                                ),
                                          ),
                                      // ),
                                      //   ],
                                      // ),
                                    );
                                  }).toList(),
                                  borderRadio: 16,
                                  prefixIcon: IconApp.category,
                                  isSizeFontSmall:
                                      searchFilterController
                                              .selectCategory
                                              .value !=
                                          null &&
                                      searchFilterController
                                          .selectCategory
                                          .value!
                                          .hasChildren,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

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
                      const SizedBox(width: 20),
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

                  const SizedBox(height: 5),

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
                          option: 'Rent',
                          optionSelected: AdType.rent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FiltterRadioWidget(
                          option: "Sell",
                          optionSelected: AdType.selling,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // SectionActiveFilterTitleWidget(
                  //   value: searchFilterController.EffectiveTypeFilter,
                  //   onChanged: (value) {
                  //     searchFilterController.activeTypeFilter();
                  //   },
                  //   FilterName: "Ad Type",
                  // ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: FiltterRadioWidget(
                  //         option: 'Buying',
                  //         optionSelected: AdType.buying,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Expanded(
                  //       child: FiltterRadioWidget(
                  //         option: "Selling",
                  //         optionSelected: AdType.selling,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 5),

                  // SectionActiveFilterTitleWidget(
                  //   value: searchFilterController.EffectivePostedFilter,
                  //   onChanged: (value) {
                  //     searchFilterController.activePostedFilter();
                  //   },
                  //   FilterName: "Posted Since",
                  // ),
                  // AppDropdownButtonFormFieldWidget(
                  //   hintText: "All in Time ",
                  //   onChanged: (value) {
                  //     if (value != null) {
                  //       searchFilterController.selectPosted.value = value
                  //           .toString();
                  //     }
                  //   },
                  //   // edit
                  //   items: [],
                  //   // edit
                  //   prefixIcon: IconApp.clarityDateLine,
                  //   borderRadio: 16,
                  // ),
                  // SizedBox(height: 5),
                  // Obx(
                  //   ()=>
                  SectionActiveFilterTitleWidget(
                    value: searchFilterController.EffectiveSortFilter,
                    onChanged: (value) {
                      searchFilterController.activeSortFilter();
                    },
                    FilterName: "Sort",
                    isSort: true,
                    ascOrDesc: searchFilterController.ascOrDesc,
                    onPressed: () {
                      searchFilterController.changeStatusSort();
                    },
                  ),
                  // ),
                  AppDropdownButtonFormFieldWidget(
                    hintText: "Sort",
                    value: searchFilterController.sortSelected.value,
                    onChanged: (value) {
                      searchFilterController.sortSelected.value = value;
                    },
                    prefixIcon: IconApp.price,
                    borderRadio: 16,
                    // validator: Validators.validateReviewAndRequestOrder,
                    items: [
                      DropdownMenuItem<String>(
                        value: "price",
                        child: Text(
                          "Price",
                          style: TypographyApp.Body_mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_400,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      DropdownMenuItem<String>(
                        value: "created_at",
                        child: Text(
                          "Created at",
                          style: TypographyApp.Body_mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_400,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  SizedBox(
                    width: size.width * 0.927,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // searchFilterController.applyFilters();
                          if (searchFilterController
                              .checkIfSelectedOnceFilter()) {
                            searchFilterController.searchAndFilter((e) {
                              Get.snackbar(
                                "Error",
                                e,
                                backgroundColor:
                                    ThemeApp.Foundation_Main_main_400,
                                colorText: ThemeApp.whiteBackground,
                              );
                            });
                            Get.back();
                          }
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
                          "Apply Filters" +
                              "${searchFilterController.numberOfEffectiveFilters() > 0 ? " (${searchFilterController.numberOfEffectiveFilters()})" : ""}",
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
        ],
      ),
    );
  }
}
