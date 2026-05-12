import 'package:servixa/features/category/data_layer/models/category_question_model.dart';

class CategoryQuestionAnswerModel {
  int id;
  dynamic value;
  String? unit_of_masure;
  CategoryQuestionModel question;
  CategoryQuestionAnswerModel({
    required this.id,
    required this.value,
    required this.question,
    required this.unit_of_masure,
  });

  factory CategoryQuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return CategoryQuestionAnswerModel(
      id: json["id"],
      value: json["value"],
      unit_of_masure: json["unit_of_masure"] == null ? null : json["unit_of_masure"],
      question: CategoryQuestionModel.fromJson(json["custom_field"]),
    );
  }

  static List<CategoryQuestionAnswerModel> listFromJson(
    List<dynamic> jsonList,
  ) {
    List<CategoryQuestionAnswerModel> answers = [];
    for (var json in jsonList) {
      answers.add(CategoryQuestionAnswerModel.fromJson(json));
    }
    return answers;
  }
}
