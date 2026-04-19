import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final String icon;
  final bool isNotLastTileList;
  final bool isLogout;
  final bool isLogin;
  ListTileWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.isNotLastTileList = true,
    this.isLogout = false,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final widthScreen = Get.width;
    return SizedBox(
      height: 45,
      child: ListTile(
        title: Text(
          title.tr(),
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: isLogout
                ? ThemeApp.Foundation_Statue_Red
                : (isLogin
                      ? ThemeApp.Foundation_Main_main_500
                      : ThemeApp.black),
          ),
        ),
        leading: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          color: isLogout
              ? ThemeApp.Foundation_Statue_Red
              : ThemeApp.Foundation_Main_main_500,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            IconApp.weuiArrowOutlined,
            width: 12,
            height: 24,
            color: isLogout
                ? ThemeApp.Foundation_Statue_Red
                : ThemeApp.Foundation_Main_main_500,
          ),
        ),
        shape: Border(
          bottom: isNotLastTileList
              ? const BorderSide(
                  color: ThemeApp.Foundation_Secendary_grey_100,
                  width: 1,
                )
              : BorderSide.none,
        ),
        contentPadding: EdgeInsetsGeometry.symmetric(
          horizontal: widthScreen * 0.05,
          vertical: 0,
        ),
        onTap: onTap,
      ),
    );
  }
}
