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
      user: UserModel.fromJson(json["user"]),
    );
  }

  static List<OrdersModel> listFromJson(Map<String, dynamic> json) {
    List<OrdersModel> orders = [];
    for (var item in json["data"]) {
      orders.add(OrdersModel.fromJson(item));
    }
    return orders;
  }
}
