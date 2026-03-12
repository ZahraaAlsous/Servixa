import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';

class UserModel {
  int id;
  String firstName;
  String lastName;
  String? email;
  String? phone;
  String? image;
  String token;
  List<BusinessAccountModel>? listBusinessAccount;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.image,
    required this.token,
    this.listBusinessAccount,
  });
}
