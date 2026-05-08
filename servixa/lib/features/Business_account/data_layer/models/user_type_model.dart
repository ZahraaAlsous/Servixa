class UserTypeModel {
  int id;
  String name;
  IconModel? icon;

  UserTypeModel({required this.id, required this.name,  this.icon});
  factory UserTypeModel.fromJson(Map<String, dynamic> json) {
    return UserTypeModel(
      id: json["id"],
      name: json["name"],
      // icon: json["icon"] ?? null,
      icon: IconModel.fromJson(json["icon"]) ,
    );
  }

  static List<UserTypeModel> listFromJson(Map<String, dynamic> json) {
    List<UserTypeModel> userTypes = [];
    for (var item in json["data"]) {
      userTypes.add(UserTypeModel.fromJson(item));
    }
    return userTypes;
  }
}

class IconModel {
  int id;
  String url;

  IconModel({required this.id, required this.url});
  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(id: json["id"], url: json["url"]);
  }
}
