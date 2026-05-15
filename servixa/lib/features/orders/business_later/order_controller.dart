import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';
import 'package:servixa/features/orders/data_layer/sourses/order_service.dart';

class OrderController extends GetxController {
  final orderService = OrderService();
  RxBool isSendOrder = false.obs;
  RxBool isLoadingOrder = false.obs;
  RxMap<int, bool> isDeletingOrders = <int, bool>{}.obs;
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

  Future<void> deleteOrder(
    int orderId,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isDeletingOrders[orderId] = true;
      bool isDeleted = await orderService.deleteOrder(orderId: orderId);
      if (isDeleted) {
        myOrders.removeWhere((order) => order.id == orderId);
        onSuccess();
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      isDeletingOrders[orderId] = false;
    }
  }

  @override
  void dispose() {
    detailsController.dispose();
    quantityController.dispose();
    super.dispose();
  }
}
