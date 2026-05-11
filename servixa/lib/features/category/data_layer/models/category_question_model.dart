import 'package:servixa/features/category/data_layer/models/meta_data_model.dart';
class CategoryQuestionModel {
  int id;
  String question;
  String type; // text, dropdown, checkbox, number
  List<String>? options; // for dropdown
  String? unitOfMeasurement;
  MetaDataModel metaData;

  CategoryQuestionModel({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    this.unitOfMeasurement,
    required this.metaData,
  });

   factory CategoryQuestionModel.fromJson(Map<String, dynamic> json) {
    return CategoryQuestionModel(
      id: json["id"],
      question: json["name"],
      type: json["type"],
      // options: json["options"] != null ? List<String>.from(json["options"]) : null,
      unitOfMeasurement: json["unit_of_masure"] ?? null,
      metaData: MetaDataModel.fromJson(json["metadata"]),
    );
  }

  static List<CategoryQuestionModel> listFromJson(List<dynamic> jsonList) {
    List<CategoryQuestionModel> questions = [];
    // for (var item in json["custom_fields"]) {
    for (var item in jsonList) {
      questions.add(CategoryQuestionModel.fromJson(item));
    }
    return questions;
  }
}
