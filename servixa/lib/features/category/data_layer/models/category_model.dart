import 'package:servixa/features/category/data_layer/models/category_question_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

class CategoryModel {
  int id;
  String name;
  String? icon;
  // edit
  // إذا مو الكل عندها تصنيفات فرعية فلازم حطها ممكن null هيك يمكن
  List<SubCategoryModel>? subCategories;
  List<CategoryQuestionModel>? questions;

  CategoryModel({
    required this.id,
    required this.name,
    this.icon,
    this.subCategories,
    this.questions,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      icon: json["icon"] ?? null,
    );
  }
}
