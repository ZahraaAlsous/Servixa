import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

class CategoryModel {
  int id;
  String name;
  String icon;
  // edit
  // إذا مو الكل عندها تصنيفات فرعية فلازم حطها ممكن null هيك يمكن
  List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.subCategories,
  });
}
