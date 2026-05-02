class CityModel {
  int id;
  String name;

  CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(id: json["id"], name: json["name"]);
  }

  static List<CityModel> listFromJson(Map<String, dynamic> json) {
    List<CityModel> cities = [];
    for (var item in json["data"]) {
      cities.add(CityModel.fromJson(item));
    }
    return cities;
  }
}
