import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/notification/business_later/notification_controller.dart';
import 'package:servixa/features/notification/presentation_layer/widgets/notification_card_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationController notificationController = Get.put(
    NotificationController(),
  );
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: ListView.builder(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        itemCount: notificationController.notifications.length,
        itemBuilder: (context, indexNotification) {
          return NotificationCardWidget(
            notification:
                notificationController.notifications[indexNotification],
          );
        },
      ),
    );
  }
}
