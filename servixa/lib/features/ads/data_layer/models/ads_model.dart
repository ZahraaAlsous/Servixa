import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';

class AdsModel {
  int id;
  String title;
  String? dictation;
  String? place;
  // String place;
  int price;
  String typeCoin;
  String image;
  bool favorite;
  List<dynamic> images;
  String typeService;
  List<ReviewModel>? listReview;
  String status;
  CategoryModel category;
  SubCategoryModel? subCategory;
  UserModel user;

  // edit
  // categore or sub category ?
  // type coin

  AdsModel({
    required this.id,
    required this.title,
    // required this.place,
    this.place,
    required this.image,
    required this.images,
    required this.favorite,
    required this.price,
    required this.typeCoin,
    this.dictation,
    required this.typeService,
    this.listReview,
    required this.status,
    required this.category,
    this.subCategory,
    required this.user,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json["id"],
      title: json["name"],
      dictation: json["description"] ?? null,
      place: json["address"] ?? null,
      image: json["main_image"],
      images: json["images"],
      favorite: json["is_favorited"],
      price: json["price"],
      typeCoin: json["price_currency"],
      typeService: json["type"],
      status: json["status"],
      category: CategoryModel.fromJson(json["category"]),
      user: UserModel.fromJson(json["user"]),
    );
  }
}
