class CategoryQuestionModel {
  int id;
  String question;
  String type; // text, dropdown, checkbox
  List<String>? options; // for dropdown

  CategoryQuestionModel({
    required this.id,
    required this.question,
    required this.type,
    this.options,
  });
}
