import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/create_business_account_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/view_business_account_screen.dart';
import 'package:servixa/features/ads/presentation_layer/screens/my_ads_screen.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/login_page.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/favorite_ad/business_layer/favorite_controller.dart';
import 'package:servixa/features/favorite_ad/presentation_layer/screens/my_favorite_screen.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';
import 'package:servixa/features/notification/presentation_layer/screens/notification_screen.dart';
import 'package:servixa/features/profile/presentation_layer/screens/edit_profile_screen.dart';
import 'package:servixa/features/profile/presentation_layer/widgets/bottom_sheet_view_profile_widget.dart';
import 'package:servixa/features/profile/presentation_layer/widgets/change_password_bottom_sheet.dart';
import 'package:servixa/features/profile/presentation_layer/widgets/list_tile_widget.dart';

class OptionProfileScreen extends StatelessWidget {
  const OptionProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final FavoriteController favoriteController = Get.put(FavoriteController());
    final CategoryController categoryController = Get.put(CategoryController());
    // final BusiessAccountController busiessAccountController = Get.put(
    //   BusiessAccountController(),
    // );
    // final size = MediaQuery.of(context).size;
    final widthScreen = Get.width;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: ListView(
        children: [
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          Center(
            child: Container(
              width: widthScreen * 0.902,
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 18,
                horizontal: 26,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ThemeApp.Foundation_Main_main_600,
                    ThemeApp.linearBackgroundCardProfile,
                  ],
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Obx(() {
                if (authController.isLoggedIn.value &&
                    authController.currentUser.value != null) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                isDismissible: true,
                                enableDrag: true,
                                isScrollControlled: true,
                                BottomSheetViewProfileWidget(),
                              );
                            },
                            child: Container(
                              width: widthScreen * 0.109,
                              height: 48.6,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      authController.currentUser.value?.image !=
                                          null
                                      ? NetworkImage(
                                          authController
                                              .currentUser
                                              .value!
                                              .image!,
                                              
                                        )
                                      : AssetImage(ImageApp.profileImage),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          Text(
                            authController.currentUser.value!.firstName +
                                " " +
                                authController.currentUser.value!.lastName,
                            style: TypographyApp.Title_Mid_Mid.copyWith(
                              color: ThemeApp.whiteBackground,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     // qustion
                          //     // مو من مكتبة الألوان
                          //     // Icon(Icons.place_outlined, color: Color(0xff6D3FAE)),
                          //     SvgPicture.asset(
                          //       IconApp.place,
                          //       width: 16,
                          //       height: 16,
                          //       color: ThemeApp.Foundation_Main_yellow_50,
                          //     ),
                          // const SizedBox(width: 5),
                          // Text(
                          //   "Riyadh – Malaz",
                          //   style:
                          //       TypographyApp
                          //           .Label_Mid_Regular.copyWith(
                          //         color: ThemeApp.whiteBackground,
                          //       ),
                          // ),
                          // ],
                          // ),
                          //   ],
                          // ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(EditProfileScreen());
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  IconApp.edit,
                                  color: ThemeApp.Foundation_Main_yellow_50,
                                ),
                                Text(
                                  "Edit".tr(),
                                  style:
                                      TypographyApp.Label_Mid_Regular.copyWith(
                                        color:
                                            ThemeApp.Foundation_Main_yellow_50,
                                      ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeApp.Foundation_Main_main_500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(),
                      Container(
                        width: widthScreen * 0.781,
                        height: 41,
                        padding: EdgeInsetsGeometry.all(7),
                        decoration: BoxDecoration(
                          color: ThemeApp.Foundation_Main_main_100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // note
                            // هون اسم الحساب؟
                            Text(
                              "Business Account".tr(),
                              style: TypographyApp.Label_Mid_Regular.copyWith(
                                color: ThemeApp.black,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(ViewBusinessAccountScreen());
                              },
                              child: Text(
                                // "Change".tr(),
                                "View".tr(),
                                style: TypographyApp.Label_Mid_Regular.copyWith(
                                  color: ThemeApp.Foundation_Main_yellow_50,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ThemeApp.Foundation_Main_main_500,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              // edit
                              // where go
                              onPressed: () {
                                // edit
                                Get.to(CreateBusinessAccountScreen());
                                // busiessAccountController.getBusinessAccount();
                                // Get.bottomSheet(
                                //   isDismissible: true,
                                //   enableDrag: true,
                                //   BottomSheetChangeAcountWidget(),
                                // );
                              },
                              child: Text(
                                // "Change".tr(),
                                "Add".tr(),
                                style: TypographyApp.Label_Mid_Regular.copyWith(
                                  color: ThemeApp.Foundation_Main_yellow_50,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ThemeApp.Foundation_Main_main_500,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return ListTile(
                  title: Text(
                    "Login to enjoy all features",
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.whiteBackground,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    icon: Icon(
                      Icons.login_rounded,
                      color: ThemeApp.whiteBackground,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: DimensApp.spaceBetweenTitleAndDetails,
              right: widthScreen * 0.05,
              left: widthScreen * 0.05,
            ),
            child: Text(
              "About The App".tr(),
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.black,
              ),
            ),
          ),
          if (authController.isLoggedIn.value)
            ListTileWidget(
              title: "navigationBarMyAds",
              // edit
              onTap: () {
                Get.to(MyAdsScreen());
              },
              icon: IconApp.myAdsListTile,
            ),
          if (authController.isLoggedIn.value)
            ListTileWidget(
              title: "Notifications",
              onTap: () {
                Get.to(NotificationScreen());
              },
              icon: IconApp.notificationsListTile,
            ),
          if (authController.isLoggedIn.value)
            ListTileWidget(
              title: "Favorite",
              // edit
              onTap: () {
                favoriteController.getMyFavorite((e) {
                  AppSnackbar.showError(e);
                });
                Get.to(() => MyFavoriteScreen());
              },
              icon: IconApp.favoriteListTile,
            ),

          ListTileWidget(
            title: "Share This App",
            // edit
            onTap: () {},
            icon: IconApp.shareOutline,
            isNotLastTileList: authController.isLoggedIn.value ? true : false,
          ),
          if (authController.isLoggedIn.value)
            ListTileWidget(
              title: "Profile Detail",
              onTap: () {
                Get.bottomSheet(
                  isDismissible: true,
                  enableDrag: true,
                  isScrollControlled: true,
                  BottomSheetViewProfileWidget(),
                );
              },
              icon: IconApp.person,
              isNotLastTileList: false,
            ),
          Padding(
            padding: EdgeInsets.only(
              top: DimensApp.spaceBetweenTitleAndDetails,
              right: widthScreen * 0.05,
              left: widthScreen * 0.05,
            ),
            child: Text(
              "Settings".tr(),
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.black,
              ),
            ),
          ),
          if (authController.isLoggedIn.value)
            ListTileWidget(
              title: "Change Password",
              // edit
              onTap: () {
                // Get.to(() => ChangePasswordBottomSheet());
                Get.bottomSheet(
                  isDismissible: true,
                  enableDrag: true,
                  isScrollControlled: true,
                  ChangePasswordBottomSheet(),
                );
              },
              icon: IconApp.changePassword,
            ),
          ListTileWidget(
            title: "Change Language",
            // edit
            onTap: () {
              if (context.locale == const Locale('en')) {
                context.setLocale(const Locale('ar'));
                Get.updateLocale(const Locale('ar'));
                categoryController.getCategories(AppSnackbar.showError);
              } else {
                context.setLocale(const Locale('en'));
                Get.updateLocale(const Locale('en'));
                categoryController.getCategories(AppSnackbar.showError);
              }
            },
            icon: IconApp.language,
          ),
          if (authController.isLoggedIn.value)
            ListTileWidget(
              title: "Logout",
              // edit
              onTap: () async {
                log("******************************Click LOGOUT");
                await authController.logout(
                  () {
                    AppSnackbar.showSuccess("Logout Success");
                    Get.offAll(() => SuperHomeScreen());
                  },
                  (e) {
                    AppSnackbar.showError(e);
                  },
                );
              },
              icon: IconApp.logout,
              isNotLastTileList: false,
              isLogout: true,
            ),
          if (!authController.isLoggedIn.value)
            ListTileWidget(
              title: "Login",
              // edit
              onTap: () {
                log("******************************Click GoLoginPage");
                Get.to(LoginPage());
              },
              icon: IconApp.logout,
              isNotLastTileList: false,
              isLogin: true,
            ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
