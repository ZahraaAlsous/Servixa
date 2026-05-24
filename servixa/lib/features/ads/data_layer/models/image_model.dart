class ImageModel {
  int id;
  String url;
  String name;

  ImageModel({required this.id, required this.url, required this.name});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json["id"], name: json["name"], url: json["url"]);
  }

  static List<ImageModel> listFromJson(List<dynamic> imagesList) {
    List<ImageModel> images = [];
    for (var item in imagesList) {
      images.add(ImageModel.fromJson(item));
    }
    return images;
  }
}
