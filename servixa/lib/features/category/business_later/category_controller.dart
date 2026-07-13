import 'dart:developer';

import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';
import 'package:servixa/features/category/data_layer/sourses/category_servic.dart';

class CategoryController extends GetxController {
  final CategoryServic categoryService = CategoryServic();
  RxBool isLoadingCategory = false.obs;
  RxBool hasErrorLoadingCategory = false.obs;
  RxBool isLoadingSubCategory = false.obs;
  RxBool hasErrorLoadingSubCategory = false.obs;
  RxBool isLoadingCategoryQuestions = false.obs;
  RxBool hasErrorLoadingCategoryQuestions = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  RxList<CategoryQuestionModel> categoryQuestions =
      <CategoryQuestionModel>[].obs;
  RxString titleCategory = "".obs;

  @override
  void onInit() {
    super.onInit();
    getCategories((String e) {}
      // AppSnackbar.showError
      );
  }

  Future<void> getCategories(void Function(String e) onError) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Get Categories IN");
      isLoadingCategory.value = true;
      hasErrorLoadingCategory.value = false;
      categories.value = await categoryService.getCategories();
      if (categories.isNotEmpty) {
        log("==============================Controller : Get Categories OK");
      }
    } catch (e) {
      hasErrorLoadingCategory.value = true;
      log("==============================Controller : Get Categories ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      onError(e.toString());
    } finally {
      isLoadingCategory.value = false;
    }
  }


  Future<void> getSubCategories(int categoryId) async {
    try {
      hasErrorLoadingSubCategory.value = false;
      isLoadingSubCategory.value = true;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Get Sub Categories IN");
      subCategories.value = await categoryService.getSubCategories(categoryId);
    } catch (e) {
      hasErrorLoadingSubCategory.value = true;
      log(
        "==============================Controller : Get Sub Categories ERROR",
      );
      // AppSnackbar.showError(e.toString());
    } finally {
      isLoadingSubCategory.value = false;
    }
  }

  List<CategoryQuestionModel> mainCategoryQuestion = [];
  List<CategoryQuestionModel> supCategoryQuestion = [];
  Future<void> getCategoryQuestions(int categoryId, bool isSupCategory) async {
    try {
      //  categoryQuestions.clear();
      isLoadingCategoryQuestions.value = true;
      hasErrorLoadingCategoryQuestions.value = false;

      log(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Get Category Questions IN",
      );
      if (!isSupCategory) {
        mainCategoryQuestion = await categoryService.getCategoryQuestions(
          categoryId,
        );
        categoryQuestions.clear();
        categoryQuestions.addAll(mainCategoryQuestion);
      }

      if (isSupCategory) {
        supCategoryQuestion = await categoryService.getCategoryQuestions(
          categoryId,
        );
        categoryQuestions.clear();
        categoryQuestions.addAll(mainCategoryQuestion);
        categoryQuestions.addAll(supCategoryQuestion);
      }
      // categoryQuestions.value = await categoryService.getCategoryQuestions(
      //   categoryId,
      // );
      log(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Get Category Questions OK",
      );
    } catch (e) {
      log(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Get Category Questions ERROR",
      );
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      hasErrorLoadingCategoryQuestions.value = true;
      // AppSnackbar.showError(e.toString());
    } finally {
      isLoadingCategoryQuestions.value = false;
    }
  }
}
