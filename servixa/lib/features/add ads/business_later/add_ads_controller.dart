import 'package:get/get.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

class AddAdsController extends GetxController {
  Rx<CategoryModel?> selectedCategoryAds = Rx<CategoryModel?>(null);
  Rx<SubCategoryModel?> selectedSubCategoryAds = Rx<SubCategoryModel?>(null);

  bool validateStepAddAds(int step) {
    switch (step) {
      case 0:
        return true;
      case 1:
        return selectedCategoryAds.value != null;
      case 2:
        if (selectedCategoryAds.value?.subCategories.isNotEmpty ?? false) {
          return selectedSubCategoryAds.value != null;
        }
        return true;
      default:
        return false;
    }
  }
}
