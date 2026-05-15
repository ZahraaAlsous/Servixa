import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/user_type_model.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';
import 'package:servixa/features/orders/data_layer/sourses/order_service.dart';

class OrderController extends GetxController {
  final orderService = OrderService();
  RxBool isSendOrder = false.obs;
  RxBool isLoadingOrder = false.obs;
  RxBool isSelectedMyOrders = false.obs;
  RxList<OrdersModel> myOrders = <OrdersModel>[].obs;
  RxList<OrdersModel> receivedOrders = <OrdersModel>[].obs;
  TextEditingController quantityController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  // Rx<BusinessAccountModel?> businessAccount = Rx<BusinessAccountModel?>(null);
  // var selectedBusinessAccountId = Rxn<int>();
  Rx<int?> selectedBusinessAccountId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    // getMyOrders();
    // getReceivedOrders();
  }

  Future<void> addOrder(
    int adId,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isSendOrder.value = true;
      bool isSendOrderDone = await orderService.addOrder(
        adId: adId,
        note: detailsController.text,
        quantity: int.parse(quantityController.text),
        // businessAccountId: businessAccount.value!.id,
        businessAccountId: selectedBusinessAccountId.value!,
        fromDate: fromDateController.text,
        toDate: toDateController.text,
      );
      if (isSendOrderDone) {
        onSuccess();
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      isSendOrder.value = false;
    }
  }

  void cleanFailed() {
    detailsController.clear();
    quantityController.clear();
    // businessAccount.value = null;
    selectedBusinessAccountId.value = null;
  }

  Future<void> getOrders(void Function(String e) onError) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: GetOrders IN");
      isLoadingOrder.value = true;
      myOrders.value = await orderService.getOrders(
        isMyOrders: isSelectedMyOrders.value ? 1 : 0,
      );
      log("==============================Controller: GetOrders OK");
    } catch (e) {
      log("==============================Controller: GetOrders ERROR");
      log("==============================The error is : $e");

      onError(e.toString());
    } finally {
      isLoadingOrder.value = false;
    }
  }

  // void getMyOrders() {
  //   myOrders.addAll([
  //     OrdersModel(
  //       id: 1,
  //       fromDate: "requestDate",
  //       details:
  //           "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",

  //       account: BusinessAccountModel(
  //         id: 1,
  //         businessNameArabic: "businessNameArabic",
  //         businessNameEnglish: "businessNameEnglish",
  //         typeBusinessAccount: UserTypeModel(id: 5, name: "name"),
  //         licenseNumber: "11111",
  //         // city: CityModel(id: 6, name: "city"),
  //         addressDetail: "addressDetail",
  //         // location: "location",
  //         activities: "activities",
  //         details:
  //             "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",
  //         documents: [],
  //         status: "status",
  //       ),
  //       status: "status",
  //       quantity: 1,
  //     ),

  //     OrdersModel(
  //       id: 2,
  //       fromDate: "requestDate2",
  //       details:
  //           "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",

  //       account: BusinessAccountModel(
  //         id: 1,
  //         businessNameArabic: "businessNameArabic",
  //         businessNameEnglish: "businessNameEnglish",
  //         typeBusinessAccount: UserTypeModel(id: 5, name: "name"),
  //         licenseNumber: "11111",
  //         // city: CityModel(id: 6, name: "city"),
  //         addressDetail: "addressDetail",
  //         // location: "location",
  //         activities: "activities",
  //         details:
  //             "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",
  //         documents: [],
  //         status: "status",
  //       ),
  //       status: "status",
  //       quantity: 1,
  //     ),
  //   ]);
  // }

  // void getReceivedOrders() {
  //   receivedOrders.addAll([
  //     OrdersModel(
  //       id: 3,
  //       fromDate: "requestDate3",
  //       details: "details3",
  //       // account: BusinessAccountModel(
  //       //   id: 1,
  //       //   businessNameArabic: "businessNameArabic",
  //       //   businessNameEnglish: "businessNameEnglish",
  //       //   typeBusinessAccount: UserTypeModel(id: 5, name: "name"),
  //       //   licenseNumber: "11111",
  //       //   // city: CityModel(id: 6, name: "city"),
  //       //   addressDetail: "addressDetail",
  //       //   // location: "location",
  //       //   activities: "activities",
  //       //   details: "details",
  //       //   documents: [],
  //       //   status: "status",
  //       // ),
  //       status: "status",
  //       quantity: 1,
  //     ),

  //     OrdersModel(
  //       id: 4,
  //       fromDate: "requestDate4",
  //       details: "details4",
  //       account: BusinessAccountModel(
  //         id: 1,
  //         businessNameArabic: "businessNameArabic",
  //         businessNameEnglish: "businessNameEnglish",
  //         typeBusinessAccount: UserTypeModel(id: 5, name: "name"),
  //         licenseNumber: "11111",
  //         // city: CityModel(id: 6, name: "city"),
  //         addressDetail: "addressDetail",
  //         // location: "location",
  //         activities: "activities",
  //         details: "details",
  //         documents: [],
  //         status: "status",
  //       ),
  //       status: "status",
  //       quantity: 1,
  //     ),
  //   ]);
  // }

  @override
  void dispose() {
    detailsController.dispose();
    quantityController.dispose();
    super.dispose();
  }
}
