import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/super_ads_screen.dart';
import 'package:servixa/features/home/presentation_layer/screens/home_page.dart';
import 'package:servixa/features/notification/presentation_layer/screens/notification_screen.dart';
import 'package:servixa/features/orders/presentation_layer/screens/super_order_screen.dart';

class SuperHomeScreen extends StatefulWidget {
  const SuperHomeScreen({super.key});

  @override
  State<SuperHomeScreen> createState() => _SuperHomeScreenState();
}

class _SuperHomeScreenState extends State<SuperHomeScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    HomePage(),
    NotificationScreen(),
    SuperAdsScreen(),
     SuperOrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: pages[selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            SuperAdsScreen(),
            // edit
            // بالتصميم حاطط dissolve
            transition: Transition.fade,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
          );
        },
        backgroundColor: ThemeApp.Foundation_Main_main_500,
        shape: const CircleBorder(),
        // child: const Icon(
        //   Icons.add,
        //   color: ThemeApp.Foundation_Main_yellow_50,
        //   size: 16,
        // ),
        child: SvgPicture.asset(
          IconApp.add,
          color: ThemeApp.Foundation_Main_yellow_50,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: ThemeApp.whiteBackground,
        // height: size.height * 0.074,
        height: 60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        padding: EdgeInsets.zero,
        // edit
        // حاسة مو مثل يلي بالتصميم
        elevation: 10,
        shadowColor: Color(0x40000000),

        child:
            // SizedBox(
            //   height: size.height * 0.074,
            //   child:
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment
              //     .stretch, // 👈 لجعل العناصر تأخذ الارتفاع الكامل
              children: [
                _buildNavItem(IconApp.home, IconApp.homeFill, "Home", 0),
                _buildNavItem(
                  IconApp.notification,
                  IconApp.notificationFill,
                  "Notification",
                  1,
                ),

                const SizedBox(width: 60),

                _buildNavItem(IconApp.ads, IconApp.adsFill, "My Ads", 2),

                _buildNavItem(IconApp.orders, IconApp.ordersFill, "Orders", 3),
              ],
            ),
        // ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String icon_fill, String label, int index) {
    final isSelected = selectedIndex == index;
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child:
            // Container(
            //   color: Colors.transparent,
            //   child:
            Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ✅ الشريط العلوي للأيقونة المحددة
                if (isSelected)
                  Container(
                    width: size.width * 0.1226,
                    // height: size.height * 0.005,
                    height: 5,
                    decoration: BoxDecoration(
                      // color:isSelected ? ThemeApp.Foundation_Main_main_500 : ThemeApp.whiteBackground,
                      color: ThemeApp.Foundation_Main_main_500,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                  ),
                SizedBox(height: 5),
                // ✅ المساحة للأيقونة والنص
                // Expanded(
                //   child: Column(
                //     // mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                SvgPicture.asset(
                  isSelected ? icon_fill : icon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? ThemeApp.Foundation_Main_main_500
                        : ThemeApp.Foundation_Secendary_grey_200,
                    BlendMode.srcIn,
                  ),
                  semanticsLabel: label,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TypographyApp.Label_Mid_Regular.copyWith(
                    color: isSelected
                        ? ThemeApp.Foundation_Main_main_500
                        : ThemeApp.Foundation_Secendary_grey_200,
                  ),
                ),
              ],
            ),
      ),
      //         ],
      //       ),
      // ),
      // ),
    );
  }
}
