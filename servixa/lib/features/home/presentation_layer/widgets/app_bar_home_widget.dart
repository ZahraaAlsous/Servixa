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
import 'package:servixa/features/profile/presentation_layer/screens/option_profile_screen.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  final AuthController authController = Get.put(AuthController());

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
              // InkWell(
              //   onTap: () {
              //     Get.to(OptionProfileScreen());
              //   },
              //   child: Container(
              //     width: size.width * 0.109,
              //     height: 48.6,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: authController.currentUser.value?.image != null
              //             ? NetworkImage(
              //                 authController.currentUser.value!.image!,
              //               )
              //             : AssetImage(ImageApp.profileImage),
              //       ),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     Get.to(() => OptionProfileScreen());
              //   },
              //   child: Container(
              //     width: size.width * 0.109,
              //     height: 48.6,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: ThemeApp.Foundation_Secendary_grey_100,
              //     ),
              //     child: ClipOval(
              //       child:
              //           authController.currentUser.value?.image != null &&
              //               authController.currentUser.value!.image!.isNotEmpty
              //           ? FadeInImage(
              //               image: NetworkImage(
              //                 authController.currentUser.value!.image!,
              //               ),
              //               placeholder: const AssetImage(
              //                 ImageApp.profileImage,
              //               ),
              //               fit: BoxFit.cover,
              //               width: size.width * 0.109,
              //               height: 48.6,
              //               imageErrorBuilder: (context, error, stackTrace) {
              //                 return Container(
              //                   width: size.width * 0.109,
              //                   height: 48.6,
              //                   color: ThemeApp.Foundation_Secendary_grey_100,
              //                   child: const Icon(
              //                     Icons.broken_image,
              //                     size: 30,
              //                     color: Colors.grey,
              //                   ),
              //                 );
              //               },
              //             )
              //           : Image.asset(
              //               ImageApp.profileImage,
              //               fit: BoxFit.cover,
              //               width: size.width * 0.109,
              //               height: 48.6,
              //             ),
              //     ),
              //   ),
              // ),
              ProfileImageWidget(
                onTap: () {
                  Get.to(() => OptionProfileScreen());
                },
              ),
              const SizedBox(width: 5),
              Column(
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

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // qustion
                      // مو من مكتبة الألوان
                      // Icon(Icons.place_outlined, color: Color(0xff6D3FAE)),
                      SvgPicture.asset(
                        IconApp.place,
                        width: 16,
                        height: 16,
                        color: ThemeApp.colorIconProfileHomeScreen,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Riyadh – Malaz",
                        style: TypographyApp.Label_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Secendary_grey_600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),
              IconButton(
                onPressed: () {},
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
              onTap: () => Get.to(OptionProfileScreen()),
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
