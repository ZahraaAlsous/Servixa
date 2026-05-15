import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';
import 'package:servixa/features/orders/presentation_layer/widgets/list_tile_order_widget.dart';

class ReceivedOrderCardWidget extends StatelessWidget {
  final OrdersModel order;

  ReceivedOrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 231,
      width: size.width * 0.8976,
      padding: EdgeInsetsGeometry.symmetric(vertical: 16, horizontal: 34),
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
          ListTileOrderWidget(
            title: "Request Date :",
            trailing: order.fromDate ?? "Not available",
          ),
          ListTileOrderWidget(title: "Service :", trailing: order.adName),
          ListTileOrderWidget(
            title: "Name :",
            trailing: order.user.firstName + " " + order.user.lastName,
          ),
          if (order.user.phone != null)
            ListTileOrderWidget(title: "Phone : ", trailing: order.user.phone!),

          if (order.user.phone == null && order.user.email != null)
            ListTileOrderWidget(title: "Email : ", trailing: order.user.email!),
          const Divider(
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
              const SizedBox(width: 10),
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
}
