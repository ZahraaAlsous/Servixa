class MetaDataModel {
  String? hint;
  bool is_required;
  List<String>? options;

  MetaDataModel({this.hint, required this.is_required, this.options});

  factory MetaDataModel.fromJson(Map<String, dynamic> json) {
    return MetaDataModel(
      hint: json["hint"],
      is_required: json["is_required"],
      options: json["options"] != null
          ? List<String>.from(json["options"])
          : null,
    );
  }
}
