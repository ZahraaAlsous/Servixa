import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/orders/business_later/order_controller.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/my_order_card_widget.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/received_order_card_widget.dart';

class OrderScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        title: Container(
          height: 48,
          width: size.width * 0.895,
          padding: EdgeInsetsGeometry.all(2),
          decoration: BoxDecoration(
            color: ThemeApp.whiteBackground,
            borderRadius: BorderRadius.circular(21),
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,

                    onTap: () {
                      orderController.isSelectedMyOrders.value = true;
                      orderController.getOrders((e) {
                        AppSnackbar.showError(e);
                      });
                    },
                    child: Container(
                      alignment: AlignmentGeometry.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: orderController.isSelectedMyOrders.value
                            ? ThemeApp.Foundation_Main_main_500
                            : ThemeApp.whiteBackground,
                      ),
                      child: Text(
                        "Received Orders",
                        style: TypographyApp.text_button_order.copyWith(
                          color: !orderController.isSelectedMyOrders.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,

                    onTap: () {
                      orderController.isSelectedMyOrders.value = false;
                      orderController.getOrders((e) {
                        AppSnackbar.showError(e);
                      });
                    },
                    child: Container(
                      alignment: AlignmentGeometry.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: !orderController.isSelectedMyOrders.value
                            ? ThemeApp.Foundation_Main_main_500
                            : ThemeApp.whiteBackground,
                      ),
                      child: Text(
                        "My Orders",
                        style: TypographyApp.text_button_order.copyWith(
                          color: orderController.isSelectedMyOrders.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: ThemeApp.whiteBackground,
      body: Column(
        children: [
          const SizedBox(height: 10),
          Obx(() {
            if (orderController.isLoadingOrder.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              height: 500,
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
                    OrdersModel order = !orderController.isSelectedMyOrders.value
                        ? orderController.myOrders[indexOrder]
                        : orderController.receivedOrders[indexOrder];
                    if (orderController.isSelectedMyOrders.value) {
                      orderController.getButtonTextByStatus(
                        order.status,
                        order.id,
                      );
                    }
                    return !orderController.isSelectedMyOrders.value
                        ? MyOrderCardWidget(order: order)
                        : ReceivedOrderCardWidget(order: order);
                  },
                );
              }),
            );
          }),
        ],
      ),
      // ),
    );
  }
}
