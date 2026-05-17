import 'package:servixa/features/category/data_layer/models/category_question_model.dart';

class CategoryModel {
  int id;
  String name;
  String? icon;
  bool hasChildren;
  int? parentId;
  List<CategoryQuestionModel>? questions;

  CategoryModel({
    required this.id,
    required this.name,
    this.icon,
    required this.hasChildren,
    this.parentId,
    this.questions,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      icon: json["icon"] ?? null,
      hasChildren: json["has_children"],
      parentId: json["parent_id"],
      questions: json["custom_fields"] != null
          ? CategoryQuestionModel.listFromJson(json["custom_fields"])
          : null,
    );
  }

  static List<CategoryModel> listFromJson(Map<String, dynamic> json) {
    List<CategoryModel> categories = [];
    for (var item in json["data"]) {
      categories.add(CategoryModel.fromJson(item));
    }
    return categories;
  }
}
