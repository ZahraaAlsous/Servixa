import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';

class OrdersModel {
  int id;
  String requestDate;
  String details;
  // String catalog;
  BusinessAccountModel account;
  String status;
  int quantity;
  // edit
  // حسب الباك
  OrdersModel({
    required this.id,
    required this.requestDate,
    required this.details,
    // qustion
    // هاد نوع الحساب التجاري؟
    required this.account,
    required this.status, // pending, accepted, rejected
    required this.quantity,
  });
}
