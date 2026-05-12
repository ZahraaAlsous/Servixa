class ImageSliderModel {
  String title;
  String url;
  String imageUrl;

  ImageSliderModel({
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  factory ImageSliderModel.fromJson(Map<String, dynamic> json) {
    return ImageSliderModel(
      title: json["title"],
      url: json["url"],
      imageUrl: json["image"] != null ? json["image"]["url"] ?? "" : "",
    );
  }

  static List<ImageSliderModel> listFromJson(Map<String, dynamic> json) {
    List<ImageSliderModel> imageSliders = [];
      for (var item in json["data"]) {
        imageSliders.add(ImageSliderModel.fromJson(item));
      }
    return imageSliders;
  }
}
