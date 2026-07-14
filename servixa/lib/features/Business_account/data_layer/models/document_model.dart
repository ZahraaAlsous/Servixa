class DocumentModel {
  final int id;
  final String url;
  final String name;

  DocumentModel({
    required this.id,
    required this.url,
    required this.name,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json["id"] ?? 0,
      url: json["url"] ?? "",
      name: json["name"] ?? "",
    );
  }

  static List<DocumentModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => DocumentModel.fromJson(item)).toList();
  }
}