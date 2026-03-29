import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/presentation_layer/screens/my_ads_screen.dart';
import 'package:servixa/features/notification/presentation_layer/screens/notification_screen.dart';
import 'package:servixa/features/profile/presentation_layer/screens/edit_profile_screen.dart';
import 'package:servixa/features/profile/presentation_layer/widgets/bottom_sheet_change_acount_widget.dart';
import 'package:servixa/features/profile/presentation_layer/widgets/bottom_sheet_view_profile_widget.dart';
import 'package:servixa/features/profile/presentation_layer/widgets/list_tile_widget.dart';

class OptionProfileScreen extends StatelessWidget {
  const OptionProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: size.width * 0.902,
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 18,
                horizontal: 26,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ThemeApp.Foundation_Main_main_600,
                    ThemeApp.linearBackgroundCardProfile,
                  ],
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
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
                          width: size.width * 0.109,
                          height: 48.6,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageApp.profileImage),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mhamad Alshame",
                            style: TypographyApp.Title_Mid_Mid.copyWith(
                              color: ThemeApp.whiteBackground,
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
                                color: ThemeApp.Foundation_Main_yellow_50,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Riyadh – Malaz",
                                style: TypographyApp.Label_Mid_Regular.copyWith(
                                  color: ThemeApp.whiteBackground,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
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
                              "Edit",
                              style: TypographyApp.Label_Mid_Regular.copyWith(
                                color: ThemeApp.Foundation_Main_yellow_50,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeApp.Foundation_Main_main_500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    width: size.width * 0.781,
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
                          "Business Account",
                          style: TypographyApp.Label_Mid_Regular.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          // edit
                          // where go
                          onPressed: () {
                            // edit
                            // Get.to(CreateBusinessAccountScreen());
                            Get.bottomSheet(
                              isDismissible: true,
                              enableDrag: true,
                              BottomSheetChangeAcountWidget(),
                            );
                          },
                          child: Text(
                            "Change",
                            style: TypographyApp.Label_Mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Main_yellow_50,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeApp.Foundation_Main_main_500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
          Padding(
            padding: EdgeInsets.only(
              top: DimensApp.spaceBetweenTitleAndDetails,
              right: size.width * 0.05,
              left: size.width * 0.05,
            ),
            child: Text(
              "About The App",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.black,
              ),
            ),
          ),
          ListTileWidget(
            title: "My Ads",
            // edit
            onTap: () {
              Get.to(MyAdsScreen());
            },
            icon: IconApp.myAdsListTile,
          ),
          ListTileWidget(
            title: "Notifications",
            onTap: () {
              Get.to(NotificationScreen());
            },
            icon: IconApp.notificationsListTile,
          ),
          ListTileWidget(
            title: "Favorite",
            // edit
            onTap: () {},
            icon: IconApp.favoriteListTile,
          ),
          ListTileWidget(
            title: "Share This App",
            // edit
            onTap: () {},
            icon: IconApp.shareOutline,
          ),
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
              right: size.width * 0.05,
              left: size.width * 0.05,
            ),
            child: Text(
              "Settings",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.black,
              ),
            ),
          ),
          ListTileWidget(
            title: "Change Password",
            // edit
            onTap: () {},
            icon: IconApp.changePassword,
          ),
          ListTileWidget(
            title: "Change Language",
            // edit
            onTap: () {},
            icon: IconApp.language,
          ),
          ListTileWidget(
            title: "Logout",
            // edit
            onTap: () {},
            icon: IconApp.logout,
            isNotLastTileList: false,
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
