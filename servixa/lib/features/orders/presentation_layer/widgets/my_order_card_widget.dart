import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/orders/business_later/order_controller.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/list_tile_order_widget.dart';

class MyOrderCardWidget extends StatelessWidget {
  final OrdersModel order;
  final OrderController orderController = Get.put(OrderController());
  MyOrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 231,
      // height: 220,
      width: size.width * 0.8976,
      padding: const EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 15),
      margin: const EdgeInsetsGeometry.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: BoxBorder.all(
          width: 1,

          color: order.status == "accepted"
              ? ThemeApp.Foundation_Main_main_500
              : ThemeApp.Foundation_Secendary_grey_100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _listTile(title: "Service : ", trailing: order.adName),
          ListTileOrderWidget(title: "Service : ", trailing: order.adName),
          ListTileOrderWidget(
            title: "Date : ",
            trailing: order.fromDate ?? "Not available",
          ),
          ListTileOrderWidget(title: "Status :", trailing: order.status),

          // Row(
          //   children: [
          // Row(
          //   children: [
          //     Text(
          //       "Detail :",
          //       style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
          //     ),
          //     Text(
          //       order.details ?? "nnnn",
          //       maxLines: 3,
          //       style: TypographyApp.Title_Mid_Mid.copyWith(
          //         color: ThemeApp.Foundation_Secendary_grey_300,
          //         overflow: TextOverflow.ellipsis
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 7),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail :",
                  style: TypographyApp.Title_Mid_Mid.copyWith(
                    color: ThemeApp.black,
                  ),
                ),

                // const SizedBox(width: 0.5),
                Expanded(
                  child: Text(
                    order.details ?? "No order details were entered.",
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    style: TypographyApp.Title_Mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_300,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            // height: 20,
            thickness: 2,
            color: ThemeApp.colorCirclesSliderAndStarAndDivider,
          ),

          Center(
            child: Obx(() {
              if (orderController.isDeletingOrders[order.id] == true) {
                return CircularProgressIndicator();
              }
              return SizedBox(
                width: size.width * 0.739,
                height: 29,
                child: OutlinedButton.icon(
                  onPressed: () => orderController.deleteOrder(
                    order.id,
                    () {
                      AppSnackbar.showSuccess("The order was deleted");
                    },
                    (e) {
                      AppSnackbar.showError(e);
                    },
                  ),
                  label: Text(
                    "Decline",
                    style: TypographyApp.Label_Mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Statue_Red,
                    ),
                  ),
                  icon: SvgPicture.asset(IconApp.delete),
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
