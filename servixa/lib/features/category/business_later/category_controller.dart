import 'package:get/get.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subCategories = <SubCategoryModel>[].obs;
  RxString titleCategory = "".obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() {
    categories.addAll([
      CategoryModel(
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
      ),
      CategoryModel(
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
      CategoryModel(
        id: 3,
        name: "Interior Design",
        icon: "assets/images/Simplification.png",
        subCategories: [
          SubCategoryModel(
            id: 1,
            name: "Heavy Vehicles",
            icon: "assets/images/Simplification.png",
          ),
        ],
      ),
      CategoryModel(
        id: 4,
        name: "Interior Design",
        icon: "assets/images/Simplification.png",
        subCategories: [
          SubCategoryModel(
            id: 1,
            name: "Heavy Vehicles",
            icon: "assets/images/Simplification.png",
          ),
        ],
      ),
      CategoryModel(
        id: 5,
        name: "Interior Design",
        icon: "assets/images/Simplification.png",
        subCategories: [],
      ),
    ]);
  }

  void getSubCategories(int categoryId) {
    CategoryModel category = categories.firstWhere(
      (item) => item.id == categoryId,
    );

    titleCategory.value = category.name;
    subCategories.value = category.subCategories;
  }
}
