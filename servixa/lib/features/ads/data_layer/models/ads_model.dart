import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/category_question_answer_model.dart';
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
  // List<ReviewModel>? listReview;
  String status;
  CategoryModel? category;
  List<CategoryQuestionAnswerModel>? categoryQuestionAnswer;
  // SubCategoryModel? subCategory;
  UserModel user;
  // edit
  // categore or sub category ?
  // type coin
  double? lat;
  double? lng;
  BusinessAccountModel? businessAccount;
  int? businessAccountId;
  bool? isRent;

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
    // this.listReview,
    required this.status,
     this.category,
    // this.subCategory,
    required this.user,
    this.categoryQuestionAnswer,
    this.lat,
    this.lng,
    this.businessAccount,
    this.isRent,
    this.businessAccountId
  });

  // factory AdsModel.fromJson(Map<String, dynamic> json) {
  //   return AdsModel(
  //     id: json["id"],
  //     title: json["name"],
  //     dictation: json["description"] ?? null,
  //     place: json["address"] ?? null,
  //     image: json["main_image"],
  //     images: json["images"],
  //     favorite: json["is_favorited"],
  //     price: int.parse(json["price"]),
  //     typeCoin: json["price_currency"],
  //     typeService: json["type"],
  //     status: json["status"],
  //     category: CategoryModel.fromJson(json["category"]),
  //     user: UserModel.fromJson(json["user"]),
  //   );
  // }

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json["id"] ?? 0,
      title: json["name"] ?? "",
      dictation: json["description"],
      place: json["address"], // الـ JSON يستخدم address
      image: json["main_image"] ?? "",
      // هنا المشكلة: الـ JSON لا يحتوي على images، سنضع قائمة فارغة كافتراض
      images: json["images"] != null
          ? (json["images"] as List)
                .map((item) => item["url"].toString())
                .toList()
          : [],
      favorite: json["is_favorited"],
      price: json["price"] is String
          ? int.parse(json["price"])
          : (json["price"] ?? 0),
      typeCoin: json["price_currency"] ?? "",
      typeService: json["type"] ?? "",
      status: json["status"] ?? "",
      // category: CategoryModel.fromJson(json["category"] ?? {}),
      category: json["category"] != null
          ? CategoryModel.fromJson(
              json["category"],
            )
          : null,
      user: UserModel.fromJson(json["user"] ?? {}),
      categoryQuestionAnswer: json["custom_field_values"] != null
          ? CategoryQuestionAnswerModel.listFromJson(
              json["custom_field_values"],
            )
          : null,
      lat: json["lat"] != null ? double.tryParse(json["lat"].toString()) : null,
      lng: json["lng"] != null ? double.tryParse(json["lng"].toString()) : null,
      businessAccount: json["business_account"] != null
          ? BusinessAccountModel.fromJson(json["business_account"])
          : null,
      // listReview: [],
      isRent: json["is_rent"],
      businessAccountId: json["business_account_id"] != null
          ? int.tryParse(json["business_account_id"].toString())
          : null
    );
  }

  static List<AdsModel> listFromJson(Map<String, dynamic> json) {
    List<AdsModel> ads = [];
    for (var item in json["data"]) {
      ads.add(AdsModel.fromJson(item));
    }
    return ads;
  }
}
