import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class AppCardAdsWidget extends StatelessWidget {
  AdsController adsController = Get.put(AdsController());
  // String assetName;
  // bool favorit;
  // int adsId;
  AdsModel ads;
  double widthCard;
  final bool isGridView;
  void Function()? onTap;
  bool isSearchCard;
  bool isMyAdd;
  AppCardAdsWidget({
    super.key,
    // required this.assetName,
    // required this.favorit,
    // required this.adsId,
    required this.ads,
    required this.widthCard,
    required this.isGridView,
    this.onTap,
    this.isSearchCard = false,
    this.isMyAdd = false
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: isGridView ? _buildGridLayout(size) : _buildListLayout(size),
    );
  }

  Widget _buildGridLayout(Size size) {
    return Container(
      width: size.width * widthCard,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        border: BoxBorder.all(
          color: ThemeApp.Foundation_Secendary_grey_50,
          width: 1,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: 126,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: AssetImage(ads.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          isMyAdd ?    Row(
                children: [
                  IconButton(
                    // edit
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      IconApp.edit,
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    // edit
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_rounded,
                      color: ThemeApp.Foundation_Statue_Red,
                    ),
                  ),
                ],
              ) : SizedBox()
            ],
          ),
          Padding(
            padding: const EdgeInsetsGeometry.only(
              right: 8,
              left: 8,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              // mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // "SPR Claw Hammers",
                  ads.title,
                  style: TypographyApp.text_button_home_page.copyWith(
                    color: ThemeApp.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.place_outlined),
                    Text(
                      // "Riyadh – Malaz",
                      ads.place,
                      style: TypographyApp.Label_Mid_Regular.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_300,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      // "500 SAK",
                      ads.price.toString() + " " + ads.typeCoin,
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        adsController.favorite(ads.id);
                      },
                      icon: SvgPicture.asset(
                        ads.favorite
                            ? IconApp.favorite
                            : IconApp.favoriteBorder,
                        color: ads.favorite
                            ? ThemeApp.Foundation_Main_main_400
                            : ThemeApp.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListLayout(Size size) {
    return Container(
      width: size.width * widthCard,
      height: 118,
      padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: ThemeApp.whiteBackground,
        border: isSearchCard
            ? BoxBorder.all(
                color: ThemeApp.Foundation_Secendary_grey_50,
                width: 1,
              )
            : null,
        boxShadow: isSearchCard
            ? [
                BoxShadow(
                  offset: const Offset(0, 16),
                  blurRadius: 32,
                  spreadRadius: -4,
                  color: Color(0xff0C0C0D1A).withOpacity(0.10),
                ),
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: -4,
                  color: Color(0xff0C0C0D1A).withOpacity(0.05),
                ),
              ]
            : null,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.230,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(ads.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ads.title,
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.black,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      IconApp.place,
                      width: 16,
                      height: 16,
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                    SizedBox(width: 5),
                    Text(
                      ads.place,
                      style: TypographyApp.Body_mid_Regular.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_300,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      ads.price.toString() + " " + ads.typeCoin,
                      style: TypographyApp.Title_Mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        adsController.favorite(ads.id);
                      },
                      icon: SvgPicture.asset(
                        ads.favorite
                            ? IconApp.favorite
                            : IconApp.favoriteBorder,
                        color: ads.favorite
                            ? ThemeApp.Foundation_Main_main_400
                            : ThemeApp.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
