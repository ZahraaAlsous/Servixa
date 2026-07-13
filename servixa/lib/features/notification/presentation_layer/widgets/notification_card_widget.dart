import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/notification/data_layer/models/notification_model.dart';
import 'package:dotted_border/dotted_border.dart';

class NotificationCardWidget extends StatelessWidget {
  NotificationModel notification;
  NotificationCardWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
    DottedBorder(
      options: RectDottedBorderOptions(
        dashPattern: [3, 3],
        strokeWidth: 1,
        borderPadding: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        color: ThemeApp.Foundation_Main_main_50,
      ),
      child: SizedBox(
        width: size.width * 0.916,
        height: 128,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    notification.type == "alert"
                        ? IconApp.notificationAlert
                        : IconApp.notificationCard,
                    color: ThemeApp.Foundation_Main_main_200,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      notification.title,
                      maxLines: 3,
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_700,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    notification.time,
                    style: TypographyApp.time_notification.copyWith(
                      color: ThemeApp.time_notification,
                    ),
                  ),
                ],
              ),
            ),
            Text(notification.body, maxLines: 3),
          ],
        ),
      ),
    );
  }
}
