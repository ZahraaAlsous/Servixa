import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'dart:async';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';

enum AdType { buying, selling }

class SearchFilterController extends GetxController {
  AdsController adsController = Get.put(AdsController());
  Timer? _debounce;
  RxList<AdsModel> adsSearchList = <AdsModel>[].obs;
  RxList<AdsModel> popularAdsList = <AdsModel>[].obs;
  RxString filterSearch = "".obs;
  RxBool EffectiveLocationFilter = false.obs;
  RxBool EffectiveCategoryFilter = false.obs;
  RxBool EffectiveSubCategoryFilter = false.obs;
  RxBool EffectiveBudgetFilter = false.obs;
  RxBool EffectiveTypeFilter = false.obs;
  RxBool EffectivePostedFilter = false.obs;
  RxString selectCategory = "".obs;
  RxString selectCategoryIcon = "".obs;
  RxString selectSubCategory = "".obs;
  Rx<int?> minPriceFilter = Rx<int?>(null);
  Rx<int?> maxPriceFilter = Rx<int?>(null);
  Rx<AdType?> selectedAdType = Rx<AdType?>(null);
  RxString selectPosted = "".obs;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    getPopularAds();
    adsSearchList.value = popularAdsList;
    minPriceController = TextEditingController();
    maxPriceController = TextEditingController();
    searchController = TextEditingController();

    // استمع للتغييرات في Rx variables وقم بتحديث الـ Controllers
    ever(minPriceFilter, (value) {
      if (value != null) {
        minPriceController.text = value.toString();
      } else {
        minPriceController.clear();
      }
    });

    ever(maxPriceFilter, (value) {
      if (value != null) {
        maxPriceController.text = value.toString();
      } else {
        maxPriceController.clear();
      }
    });

    ever(filterSearch, (value) {
      searchController.text = value;
    });
  }

  void getPopularAds() {
    popularAdsList.addAll([
      AdsModel(
        id: 1,
        title: "SPR Claw Hammers1",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "Sp",
        typeService: "Rent",
        status: "accept",
        listReview: [
          ReviewModel(
            id: 1,
            text: "very beatufull",
            user: UserModel(id: 1, firstName: "Zahraa", lastName: "Alsous"),
            date: "6/15/2026",
          ),
        ],
        category: CategoryModel(
          id: 2,
          name: "Interior Design",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
            SubCategoryModel(
              id: 2,
              name: "Plumbing & Electrical",
              icon: "assets/images/Simplification.png",
            ),
          ],
        ),

        subCategory: SubCategoryModel(
          id: 2,
          name: "Plumbing & Electrical",
          icon: "assets/images/Simplification.png",
        ),
      ),
      AdsModel(
        id: 2,
        title: "SPR Claw Hammers2",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
        category: CategoryModel(
          id: 1,
          name: "Equipment",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
          ],
          questions: [
            CategoryQuestionModel(
              id: 1,
              question: "question text",
              type: "text",
            ),
            CategoryQuestionModel(
              id: 2,
              question: "question dropdown",
              type: "dropdown",
              options: ["1", "2", "3"],
            ),
            CategoryQuestionModel(
              id: 3,
              question: "question checkbox",
              type: "checkbox",
            ),
          ],
        ),
      ),
      AdsModel(
        id: 3,
        title: "SPR Claw Hammers3",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
        category: CategoryModel(
          id: 2,
          name: "Interior Design",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
            SubCategoryModel(
              id: 2,
              name: "Plumbing & Electrical",
              icon: "assets/images/Simplification.png",
            ),
          ],
        ),
      ),
      AdsModel(
        id: 4,
        title: "SPR Claw Hammers4",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
        category: CategoryModel(
          id: 1,
          name: "Equipment",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
          ],
          questions: [
            CategoryQuestionModel(
              id: 1,
              question: "question text",
              type: "text",
            ),
            CategoryQuestionModel(
              id: 2,
              question: "question dropdown",
              type: "dropdown",
              options: ["1", "2", "3"],
            ),
            CategoryQuestionModel(
              id: 3,
              question: "question checkbox",
              type: "checkbox",
            ),
          ],
        ),
      ),
      AdsModel(
        id: 5,
        title: "SPR Claw Hammers5",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
        category: CategoryModel(
          id: 2,
          name: "Interior Design",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
            SubCategoryModel(
              id: 2,
              name: "Plumbing & Electrical",
              icon: "assets/images/Simplification.png",
            ),
          ],
        ),
      ),
    ]);
  }

  void onSearchChanged(String query) {
    filterSearch.value = query;
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      applyFilters();
    });
  }

  void activeLocationFilter() {
    EffectiveLocationFilter.value = !EffectiveLocationFilter.value;
  }

  void activeCategoryFilter() {
    EffectiveCategoryFilter.value = !EffectiveCategoryFilter.value;
  }

  void activeSubCategoryFilter() {
    EffectiveSubCategoryFilter.value = !EffectiveSubCategoryFilter.value;
  }

  void activeBudgetFilter() {
    EffectiveBudgetFilter.value = !EffectiveBudgetFilter.value;
  }

  void activeTypeFilter() {
    EffectiveTypeFilter.value = !EffectiveTypeFilter.value;
  }

  void activePostedFilter() {
    EffectivePostedFilter.value = !EffectivePostedFilter.value;
  }

  void applyFilters() {
    // edit
    searchAndFilter(
      name: filterSearch.value.isEmpty ? null : filterSearch.value,
      categoryName:
          selectCategory.value.isEmpty || !EffectiveCategoryFilter.value
          ? null
          : selectCategory.value,
      subCategory:
          selectCategory.value.isEmpty ||
              !EffectiveCategoryFilter.value ||
              selectSubCategory.value.isEmpty ||
              !EffectiveSubCategoryFilter.value
          ? null
          : selectSubCategory.value,
    );
  }

  void searchAndFilter({
    String? name,
    String? location,
    String? categoryName,
    String? subCategory,
    int? minPrice,
    int? maxPrice,
    String? type,
    String? posted,
  }) {
    adsSearchList.value = adsController.adsList;

    name != null ? searchResault(name) : adsSearchList;
    location != null ? adsSearchList : adsSearchList;
    categoryName != null ? filterByCategory(categoryName) : adsSearchList;
    subCategory != null ? adsSearchList : adsSearchList;
    minPrice != null ? adsSearchList : adsSearchList;
    maxPrice != null ? adsSearchList : adsSearchList;
    type != null ? adsSearchList : adsSearchList;
    posted != null ? adsSearchList : adsSearchList;
  }

  void searchResault(String? name) {
    adsSearchList.value = adsController.adsList
        // .where((item) => item.title == name)
        .where((item) => item.title.toLowerCase().contains(name!.toLowerCase()))
        .toList();
  }

  void filterByCategory(String? categoryName) {
    adsSearchList.value = adsSearchList
        .where((item) => item.category.name == categoryName)
        .toList();
  }

  void resetSearchFilterToInitialState() {
    filterSearch.value = "";
    EffectiveLocationFilter.value = false;
    EffectiveCategoryFilter.value = false;
    EffectiveSubCategoryFilter.value = false;
    EffectiveBudgetFilter.value = false;
    EffectiveTypeFilter.value = false;
    EffectivePostedFilter.value = false;
    selectCategory.value = "";
    selectCategoryIcon.value = "";
    adsSearchList.value = List.of(popularAdsList);
    selectedAdType.value = null;
    selectSubCategory.value = "";
    minPriceFilter.value = null;
    maxPriceFilter.value = null;
    selectPosted.value = "";

    minPriceController.clear();
    maxPriceController.clear();
    searchController.clear();
  }

  bool isDisplayTitleSearchResults() {
    return filterSearch.value != "" ||
        EffectiveLocationFilter.value ||
        EffectiveCategoryFilter.value ||
        EffectiveSubCategoryFilter.value ||
        EffectiveBudgetFilter.value ||
        EffectiveTypeFilter.value ||
        EffectivePostedFilter.value;
  }

  // RxInt numberOfEffectiveFilters() {
  //   int num = 0;
  //   if (EffectiveLocationFilter.value) {
  //     num = num + 1;
  //   }
  //   if (EffectiveCategoryFilter.value) {
  //     num = num + 1;
  //   }
  //   if (EffectiveSubCategoryFilter.value) {
  //     num = num + 1;
  //   }
  //   if (EffectiveBudgetFilter.value) {
  //     num = num + 1;
  //   }
  //   if (EffectiveTypeFilter.value) {
  //     num = num + 1;
  //   }
  //   if (EffectivePostedFilter.value) {
  //     num = num + 1;
  //   }
  //   return num.obs;
  // }

  // استبدل الدالة الموجودة بهذه
  int numberOfEffectiveFilters() {
    int count = 0;

    if (EffectiveLocationFilter.value) count++;
    if (EffectiveCategoryFilter.value) count++;
    if (EffectiveSubCategoryFilter.value) count++;
    if (EffectiveBudgetFilter.value) count++;
    if (EffectiveTypeFilter.value) count++;
    if (EffectivePostedFilter.value) count++;

    // if (filterSearch.value.isNotEmpty) count++;
    // if (selectCategory.value.isNotEmpty && EffectiveCategoryFilter.value)
    //   count++;
    // if (selectedAdType.value != null && EffectiveTypeFilter.value) count++;
    // if (minPriceFilter.value != null && EffectiveBudgetFilter.value) count++;
    // if (maxPriceFilter.value != null && EffectiveBudgetFilter.value) count++;
    // if (selectPosted.value.isNotEmpty && EffectivePostedFilter.value) count++;

    return count;
  }

  // int numberOfEffectiveFilters() {
  //     return [
  //       EffectiveLocationFilter.value,
  //       EffectiveCategoryFilter.value,
  //       EffectiveSubCategoryFilter.value,
  //       EffectiveBudgetFilter.value,
  //       EffectiveTypeFilter.value,
  //       EffectivePostedFilter.value,
  //     ].where((isActive) => isActive).length;
  //   }
  @override
  void dispose() {
    _debounce?.cancel();
    // minPriceController.dispose();
    // maxPriceController.dispose();
    // adsSearchList.clear();
    // _controller.dispose();
    //  filterSearch = "".obs;
    //  EffectiveLocationFilter = false.obs;
    //  EffectiveCategoryFilter = false.obs;
    //  EffectiveSubCategoryFilter = false.obs;
    //  EffectiveBudgetFilter = false.obs;
    //  EffectiveTypeFilter = false.obs;
    //  EffectivePostedFilter = false.obs;
    //  selsctCategory = "".obs;
    minPriceController.dispose();
    maxPriceController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
