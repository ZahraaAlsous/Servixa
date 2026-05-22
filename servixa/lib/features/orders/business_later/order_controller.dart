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
  Rx<int?> selectedBusinessAccountId = Rx<int?>(null);
  // RxMap<int, String> buttonTexts = <int, String>{}.obs;
  RxMap<int, bool> isUpdatingOrders = <int, bool>{}.obs;

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
    fromDateController.clear();
    // businessAccount.value = null;
    selectedBusinessAccountId.value = null;
  }

  Future<void> getOrders(void Function(String e) onError) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: GetOrders IN");
      isLoadingOrder.value = true;
      if (isSelectedMyOrders.value) {
        receivedOrders.value = await orderService.getOrders(isMyOrders: 1);
        // for (var order in receivedOrders) {
        //   getButtonTextByStatus(order.status, order.id);
        // }
      } else {
        myOrders.value = await orderService.getOrders(isMyOrders: 0);
      }
      // myOrders.value = await orderService.getOrders(
      //   isMyOrders: isSelectedMyOrders.value ? 1 : 0,
      // );
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

  Future<void> updateStatusOrder(
    int orderId,
    // String status,
    int status,
    void Function(String status) onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: UpdateStatusOrder IN");
      isUpdatingOrders[orderId] = true;
      bool isUpdated = await orderService.updateStatusOrder(
        orderId: orderId,
        // status: sendNumStatus(status),
        status: status,
      );
      if (isUpdated) {
        log("==============================Controller : UpdateStatusOrder OK");

        // String newStatus = numStatus(sendNumStatus(status));
        // updateStatusOrderLocal(orderId, newStatus);
        // getButtonTextByStatus(status, orderId);
        // onSuccess(newStatus);

        updateStatusOrderLocal(orderId, status == 2 ? "accepted" : "rejected");
        onSuccess(status == 2 ? "Accepted" : "Rejected");
      }
    } catch (e) {
      log("==============================Controller : UpdateStatusOrder ERROR");

      onError(e.toString());
    } finally {
      isUpdatingOrders[orderId] = false;
    }
  }

  void updateStatusOrderLocal(int orderId, String status) {
    try {
      final index = receivedOrders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        receivedOrders[index].status = status;
        receivedOrders.refresh();
      }
    } catch (e) {
      log("Order not found: $orderId");
    }
  }

  // int sendNumStatus(String status) {
  //   switch (status) {
  //     case "pending":
  //       return 2;
  //     case "accepted":
  //       return 3;
  //     case "completed":
  //       return 4;
  //     case "rejected":
  //       return 5;
  //     default:
  //       return 1;
  //   }
  // }

  // String numStatus(int statusNum) {
  //   switch (statusNum) {
  //     case 1:
  //       return "pending";
  //     case 2:
  //       return "accepted";
  //     case 3:
  //       return "completed";
  //     case 4:
  //       return "cancelled";
  //     case 5:
  //       return "rejected";
  //     default:
  //       return "pending";
  //   }
  // }

  // void getButtonTextByStatus(String status, int orderId) {
  //   switch (status) {
  //     case 'pending':
  //       buttonTexts[orderId] = "Accept";
  //       break;
  //     case 'accepted':
  //       buttonTexts[orderId] = "Completed";
  //       break;
  //     case 'completed':
  //       buttonTexts[orderId] = "Cancelled";
  //       break;
  //     case 'rejected':
  //       buttonTexts[orderId] = "Rejected";
  //       break;
  //     case 'cancelled':
  //       buttonTexts[orderId] = "Cancelled";
  //       break;
  //     default:
  //       buttonTexts[orderId] = "Pending";
  //   }
  // }

  @override
  void dispose() {
    detailsController.dispose();
    quantityController.dispose();
    fromDateController.dispose();
    super.dispose();
  }
}
