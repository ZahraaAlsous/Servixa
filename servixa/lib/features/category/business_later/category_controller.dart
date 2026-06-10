import 'dart:developer';

import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_snackbar.dart';
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
    getCategories(AppSnackbar.showError);
    // // getCategories();
    // ever(isLoadingCategory, (_) {
    //   if (!isLoadingCategory.value && categories.isEmpty) {
    //     Future.delayed(Duration(seconds: 5), () {
    //       if (categories.isEmpty) {
    //         log('⏰ مرت 5 ثوانٍ وما زالت قائمة الفئات فارغة');
    //         log('🚀 إعادة محاولة تحميل الفئات...');
    //         getCategories(AppSnackbar.showError);
    //       } else {
    //         log('✅ تم تحميل الفئات خلال فترة الانتظار');
    //       }
    //     });
    //   }
    // });
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

  // void getCategories() {
  //   categories.addAll([
  //     CategoryModel(
  //       id: 1,
  //       name: "Equipment",
  //       icon: "assets/images/Simplification.png",
  //       hasChildren: false,
  //       subCategories: [
  //         //   SubCategoryModel(
  //         //     id: 1,
  //         //     name: "Heavy Vehicles",
  //         //     icon: "assets/images/Simplification.png",
  //         //   ),
  //       ],
  //       questions: [
  //         CategoryQuestionModel(id: 1, question: "question text", type: "text"),
  //         CategoryQuestionModel(
  //           id: 2,
  //           question: "question dropdown",
  //           type: "dropdown",
  //           options: ["1", "2", "3"],
  //         ),
  //         CategoryQuestionModel(
  //           id: 3,
  //           question: "question checkbox",
  //           type: "checkbox",
  //         ),
  //       ],
  //     ),

  //     CategoryModel(
  //       id: 2,
  //       name: "Interior Design",
  //       icon: "assets/images/Simplification.png",
  //       hasChildren: true,

  //       subCategories: [
  //         SubCategoryModel(
  //           id: 1,
  //           name: "Heavy Vehicles",
  //           icon: "assets/images/Simplification.png",
  //         ),
  //         SubCategoryModel(
  //           id: 2,
  //           name: "Plumbing & Electrical",
  //           icon: "assets/images/Simplification.png",
  //         ),
  //       ],
  //     ),
  //   ]);
  // }

  // void getSubCategories(int categoryId) {
  //   CategoryModel category = categories.firstWhere(
  //     (item) => item.id == categoryId,
  //   );

  //   titleCategory.value = category.name;
  //   subCategories.value = category.subCategories!;
  // }

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
