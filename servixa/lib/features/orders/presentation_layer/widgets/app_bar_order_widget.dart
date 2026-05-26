import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/orders/business_later/order_controller.dart';

class AppBarOrderWidget extends StatelessWidget implements PreferredSizeWidget {
  final OrderController orderController = Get.put(OrderController());

  AppBarOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppBarWidget(
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
                      "Received Orders".tr(),
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
                      "My Orders".tr(),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
