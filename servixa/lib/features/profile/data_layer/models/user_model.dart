import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';

class UserModel {
  int id;
  String firstName;
  String lastName;
  String? email;
  String? phone;
  String? image;
  // List<BusinessAccountModel>? listBusinessAccount;
  bool has_business_account;
  String name;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.image,
    // this.listBusinessAccount,
    this.has_business_account = false,
    required this.name
  });

    factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"] ?? null,
      phone: json["phone_number"] ?? null,
      image: json["image"] ?? null,
      // listBusinessAccount: (json["business_accounts"] as List<dynamic>?)
      //     ?.map((account) => BusinessAccountModel.fromJson(account))
      //     .toList(),
      name: json["name"],
      has_business_account: json["has_business_account"],
    );
  }

}
