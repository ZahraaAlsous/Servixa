import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/orders/business_later/order_controller.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';

class SuperOrderScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  SuperOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBarWidget(),
      appBar: AppBar(backgroundColor: ThemeApp.linearBackground),
      backgroundColor: ThemeApp.whiteBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeApp.linearBackground, ThemeApp.whiteBackground],
            stops: [0.0, 0.1],
          ),
        ),
        child: Column(
          children: [
            Container(
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
                      () => ElevatedButton(
                        onPressed: () {
                          orderController.isSelectedMyOrders.value = false;
                        },
                        child: Text(
                          "Received Orders",
                          style: TypographyApp.text_button_order.copyWith(
                            color: orderController.isSelectedMyOrders.value
                                ? ThemeApp.Foundation_Main_main_500
                                : ThemeApp.whiteBackground,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              !orderController.isSelectedMyOrders.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          orderController.isSelectedMyOrders.value = true;
                        },
                        child: Text(
                          "My Orders",
                          style: TypographyApp.text_button_order.copyWith(
                            color: !orderController.isSelectedMyOrders.value
                                ? ThemeApp.Foundation_Main_main_500
                                : ThemeApp.whiteBackground,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              orderController.isSelectedMyOrders.value
                              ? ThemeApp.Foundation_Main_main_500
                              : ThemeApp.whiteBackground,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 500,
              child: Obx(() {
                return ListView.builder(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                  ),
                  itemCount: orderController.isSelectedMyOrders.value
                      ? orderController.myOrders.length
                      : orderController.receivedOrders.length,
                  itemBuilder: (context, indexOrder) {
                    return orderController.isSelectedMyOrders.value
                        ? myOrders(size, orderController.myOrders[indexOrder])
                        : receivedOrders(
                            size,
                            orderController.receivedOrders[indexOrder],
                          );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedOrders(Size size, OrdersModel order) {
    return Container(
      height: 231,
      width: size.width * 0.8976,
      padding: EdgeInsetsGeometry.symmetric(vertical: 22, horizontal: 34),
      margin: EdgeInsetsGeometry.symmetric(vertical: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: BoxBorder.all(
          width: 1,
          color: ThemeApp.Foundation_Secendary_grey_100,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Request Date :",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              Spacer(),
              Text(
                order.requestDate,
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ],
          ),
          SizedBox(height: 9),
          Row(
            children: [
              Text(
                "Catalog :",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              Spacer(),
              Text(
                "kjkjkjkjs",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ],
          ),
          SizedBox(height: 9),

          Row(
            children: [
              Text(
                "Name :",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              Spacer(),
              Text(
                order.account.businessNameEnglish,
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ],
          ),
          SizedBox(height: 9),

          Row(
            children: [
              Text(
                "Phone :",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              Spacer(),
              Text(
                "kjkjkjkjs",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ],
          ),
          // SizedBox(height: 9),
          Divider(
            height: 20,
            thickness: 2,
            color: ThemeApp.colorCirclesSliderAndStarAndDivider,
          ),

          // SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Accept",
                    style: TypographyApp.Label_Mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_yellow_50,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    backgroundColor: ThemeApp.Foundation_Statue_Green,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Decline",
                    style: TypographyApp.Label_Mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Statue_Red,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(
                      color: ThemeApp.Foundation_Statue_Red,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myOrders(Size size, OrdersModel order) {
    log(order.details);

    return Container(
      height: 231,
      width: size.width * 0.8976,
      padding: EdgeInsetsGeometry.symmetric(vertical: 22, horizontal: 8),
      margin: EdgeInsetsGeometry.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: BoxBorder.all(
          width: 1,
          color: ThemeApp.Foundation_Secendary_grey_100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Request Date :",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              Spacer(),
              Text(
                order.requestDate,
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text(
                "Catalog :",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              Spacer(),
              Text(
                "kjkjkjk2js",
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),

          // Row(
          //   children: [
          Text(
            "Detail :",
            style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
          ),
          Text(
            order.details,
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_300,
            ),
          ),
          SizedBox(height: 6),

          Divider(
            height: 20,
            thickness: 2,
            color: ThemeApp.colorCirclesSliderAndStarAndDivider,
          ),

          // SizedBox(height: 9),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                "Decline",
                style: TypographyApp.Label_Mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Statue_Red,
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: ThemeApp.Foundation_Statue_Red,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
