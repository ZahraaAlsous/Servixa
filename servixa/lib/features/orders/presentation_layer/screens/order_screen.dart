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
        padding: const EdgeInsets.only(bottom: 60),
        child: Obx(() {
          if (orderController.isLoadingOrder.value) {
            if (orderController.isSelectedMyOrders.value) {
              return ShimmerReceivedOrderCardList();
            } else {
              return ShimmerMyOrderCardList();
            }
          }

          if (orderController.hasErrorLoadingOrders.value) {
            return InternetConnectionErrorWidget(
              onPressed: () {
                orderController.getOrders((e) {});
              },
            );
          }

          if (orderController.myOrders.isEmpty &&
              !orderController.isSelectedMyOrders.value) {
            return AppNothingWidget();
          }

          if (orderController.receivedOrders.isEmpty &&
              orderController.isSelectedMyOrders.value) {
            return AppNothingWidget();
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * DimensApp.spaceHorizontalScreen,
            ),
            itemCount: !orderController.isSelectedMyOrders.value
                ? orderController.myOrders.length
                : orderController.receivedOrders.length,
            itemBuilder: (context, indexOrder) {
              OrdersModel order = !orderController.isSelectedMyOrders.value
                  ? orderController.myOrders[indexOrder]
                  : orderController.receivedOrders[indexOrder];

              return !orderController.isSelectedMyOrders.value
                  ? MyOrderCardWidget(order: order)
                  : ReceivedOrderCardWidget(order: order);
            },
          );
        }),
      ),
    );
  }
}
