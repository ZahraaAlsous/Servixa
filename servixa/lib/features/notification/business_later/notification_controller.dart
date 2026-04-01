import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/notification/data_layer/models/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(
      id: 1,
      title: "The booking for the Homs to Damascus flight has been confirmed.",
      body:
          "Order invoice number 3423424 is ready and you can verify it here or by checking your WhatsApp.",
      type: "notification",
      time: "16:00",
    ),
    NotificationModel(
      id: 2,
      title: "There is a payment problem; you will lose your account.",
      body:
          "Order invoice number 3423424 is ready and you can verify it here or by checking your WhatsApp.",
      type: "alert",
      time: "16:00",
    ),
  ].obs;
}
