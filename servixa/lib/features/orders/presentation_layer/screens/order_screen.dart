import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_my_order_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_received_order_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/orders/business_later/order_controller.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/app_bar_order_widget.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/my_order_card_widget.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/received_order_card_widget.dart';

class OrderScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarOrderWidget(),
      backgroundColor: ThemeApp.whiteBackground,
      body: Padding(
        padding: EdgeInsetsGeometry.only(
          bottom: 60,
        ),
        child: Obx(() {
          if (orderController.isLoadingOrder.value) {
            // return const Center(child: CircularProgressIndicator());
            // return LoadingAnimationWidget(
            //   message: "Loading orders...".tr(),
            //   showLogo: true,
            // );
            if (orderController.isSelectedMyOrders.value) {
              return Expanded(child: ShimmerReceivedOrderCardList());
            }
            if (!orderController.isSelectedMyOrders.value) {
              return Expanded(child: ShimmerMyOrderCardList());
            }
          }
          if (orderController.hasErrorLoadingOrders.value) {
            return Expanded(
              child: InternetConnectionErrorWidget(
                onPressed: () {
                  orderController.getOrders((e) {});
                },
              ),
            );
          }
          if (orderController.myOrders.isEmpty &&
              !orderController.isSelectedMyOrders.value) {
            return Expanded(child: AppNothingWidget());
          }
          if (orderController.receivedOrders.isEmpty &&
              orderController.isSelectedMyOrders.value) {
            return Expanded(child: AppNothingWidget());
          }
          return
          // SizedBox(
          //   height: 500,
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: size.width * DimensApp.spaceHorizontalScreen,
                ),
                itemCount: !orderController.isSelectedMyOrders.value
                    ? orderController.myOrders.length
                    : orderController.receivedOrders.length,
                // itemCount: orderController.myOrders.length,
                itemBuilder: (context, indexOrder) {
                  OrdersModel order =
                      !orderController.isSelectedMyOrders.value
                      ? orderController.myOrders[indexOrder]
                      : orderController.receivedOrders[indexOrder];
                  // if (orderController.isSelectedMyOrders.value) {
                  //   orderController.getButtonTextByStatus(
                  //     order.status,
                  //     order.id,
                  //   );
                  // }
                  return !orderController.isSelectedMyOrders.value
                      ? MyOrderCardWidget(order: order)
                      : ReceivedOrderCardWidget(order: order);
                },
              );
            }),
          );
        }),
      ),
      // ),
    );
  }
}
