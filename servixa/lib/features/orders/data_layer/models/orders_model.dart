// import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';

// class OrdersModel {
//   int id;
//   String? orderNumber;
//   String fromDate;
//   String toDate;
//   String details;
//   // String catalog;
//   // BusinessAccountModel account;
//   String status;
//   int quantity;
//   // edit
//   // حسب الباك
//   OrdersModel({
//     required this.id,
//     required this.fromDate,
//     required this.toDate,
//     required this.details,
//     // // qustion
//     // // هاد نوع الحساب التجاري؟
//     // required this.account,
//     required this.status, // pending, accepted, rejected
//     required this.quantity,
//     this.orderNumber
//   });

//     factory OrdersModel.fromJson(Map<String, dynamic> json) {
//     return OrdersModel(id: json["id"], orderNumber: json["order_number"],  fromDate: json["ads"]["from_date"],toDate: json["ads"]["to_date"], details: ["ads"]["note"], status: json["status"], quantity: int.parse(json["ads"]["quantity"]));

//   }

//   static List<OrdersModel> listFromJson(Map<String, dynamic> json) {
//     List<OrdersModel> orders = [];
//     for (var item in json["data"]) {
//       orders.add(OrdersModel.fromJson(item));
//     }
//     return orders;
//   }

// }
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';

class OrdersModel {
  int id;
  String orderNumber;
  double price;
  int quantity;
  String? fromDate;
  String? toDate;
  String? details;
  // AdsModel ad;
  String adName;
  String status;
  UserModel user;

  OrdersModel({
    required this.id,
    required this.orderNumber,
    required this.price,
    required this.quantity,
    this.fromDate,
    this.toDate,
    this.details,
    // required this.ad,
    required this.adName,
    required this.status,
    required this.user,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json["id"] ?? 0,
      orderNumber: json["order_number"] ?? "0",
      price: (json["total"]).toDouble(),
      quantity: json["ads"][0]["quantity"] ?? 0,
      fromDate: json["ads"][0]["from_date"],
      toDate: json["ads"][0]["to_date"],
      details: json["ads"][0]["note"],
      // ad: json["ads"][0]["ad"]["name"],
      adName: json["ads"][0]["ad"]["name"],
      status: json["status"],
      user: UserModel.fromJson(json["user"])
    );
  }

  static List<OrdersModel> listFromJson(Map<String, dynamic> json) {
    List<OrdersModel> orders = [];
    // if (json["data"] != null && json["data"] is List) {
      for (var item in json["data"]) {
        orders.add(OrdersModel.fromJson(item));
      }
    // }
    return orders;
  }
}
