import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';

class AdsModel {
  int id;
  String title;
  String? dictation;
  String place;
  double price;
  String typeCoin;
  String image;
  bool favorite;
  List<String> images;
  String typeService;
  List<ReviewModel>? listReview;
  String status;
  CategoryModel category;
  SubCategoryModel? subCategory;

  // edit
  // categore or sub category ?
  // type coin

  AdsModel({
    required this.id,
    required this.title,
    required this.place,
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
  });
}
