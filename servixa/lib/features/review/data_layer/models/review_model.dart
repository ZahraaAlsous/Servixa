import 'package:servixa/features/profile/data_layer/models/user_model.dart';

class ReviewModel {
  int id;
  String text;
  UserModel user;
  String date;

  ReviewModel({
    required this.id,
    required this.text,
    required this.user,
    required this.date,
  });
}
