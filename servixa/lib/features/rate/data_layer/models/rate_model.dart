import 'package:servixa/features/profile/data_layer/models/user_model.dart';

class RateModel {
  int id;
  int rate;
  String? comment;
  UserModel user;
  String createdAt;

  RateModel({
    required this.id,
    required this.rate,
    this.comment,
    required this.user,
    required this.createdAt
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json["id"],
      rate: json["rate"],
      comment: json["comment"],
      user: UserModel.fromJson(json["user"]),
      createdAt: json["created_at"]
    );
  }

  static List<RateModel> listFromJson(Map<String, dynamic> json) {
    List<RateModel> rates = [];
    for (var item in json["ratings"]) {
      rates.add(RateModel.fromJson(item));
    }
    return rates;
  }
}
