import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/profile_image_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/location%20user/business_layer/location_controller.dart';
import 'package:servixa/features/profile/presentation_layer/screens/option_profile_screen.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  // final AuthController authController = Get.put(AuthController());
   final AuthController authController = Get.find<AuthController>();
  // final LocationController locationController = Get.put(LocationController());
   final LocationController locationController = Get.find<LocationController>();

  AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppBarWidget(
      title: Obx(() {
        if (authController.isLoggedIn.value &&
            authController.currentUser.value != null) {
          return Row(
            children: [
              ProfileImageWidget(
                onTap: () {
                  Get.to(() => OptionProfileScreen());
                },
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authController.currentUser.value!.firstName +
                          " " +
                          authController.currentUser.value!.lastName,
                      style: TypographyApp.Title_Mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Grey_grey_700,
                      ),
                    ),
                    Obx(() {
                      if (locationController
                          .addressUserSelected
                          .value
                          .isNotEmpty) {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              IconApp.place,
                              width: 16,
                              height: 16,
                              color: ThemeApp.colorIconProfileHomeScreen,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                locationController.addressUserSelected.value,
                                style: TypographyApp.Label_Mid_Regular.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),

              const Spacer(),
              IconButton(
                onPressed: () {
                  // locationController.cleanLocationVariables();
                  // Get.to(() => LocationPickerScreen());
                },
                icon: SvgPicture.asset(
                  IconApp.location,
                  width: 34,
                  height: 34,
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
            ],
          );
        }
        return Row(
          children: [
            InkWell(
              onTap: () => Get.to(() => OptionProfileScreen()),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: ThemeApp.Foundation_Main_main_100,
                child: Icon(
                  Icons.person_outline,
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, Guest".tr(),
                  style: TypographyApp.Title_Mid_Mid.copyWith(
                    color: ThemeApp.black,
                  ),
                ),
                Text(
                  "Login to enjoy all features".tr(),
                  style: TypographyApp.Label_Mid_Mid.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
