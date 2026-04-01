import 'dart:async';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/bottom_sheet_add_order_widget.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/bottom_sheet_portfolio_widget.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/bottom_sheet_review_widget.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/space_between_section_widget.dart';
import 'package:servixa/features/home/business_later/home_controller.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:readmore/readmore.dart';
import 'package:servixa/common/widgets/app_title_section_widget.dart';
import 'package:servixa/features/rate/presentation_layer/widgets/rate_star_widget.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdsDetailsScreen extends StatefulWidget {
  int adsId;
  AdsDetailsScreen({super.key, required this.adsId});

  @override
  State<AdsDetailsScreen> createState() => _AdsDetailsScreenState();
}

class _AdsDetailsScreenState extends State<AdsDetailsScreen> {
  AdsController adsController = Get.put(AdsController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    adsController.getAdsDetails(widget.adsId);

    super.initState();
  }

  Widget _getStarColor(int starIndex, double rating) {
    double starNumber = starIndex + 1.0;
    double difference = starNumber - rating;
    if (difference <= 0) {
      return SvgPicture.asset(IconApp.starFill);
    } else if (difference < 1) {
      return Icon(Icons.star_half, color: ThemeApp.Foundation_Main_main_500);
    } else {
      return SvgPicture.asset(IconApp.starNotFill);
    }
  }

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    AdsModel ads = adsController.adsDetails.value!;
    final size = MediaQuery.of(context).size;
    bool showMore = adsController.showMore.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              // edit
              // function from back
            },
            icon: SvgPicture.asset(
              IconApp.report,
              width: 24,
              height: 24,
              color: ThemeApp.Foundation_Main_main_500,
            ),
          ),

          IconButton(
            onPressed: () {
              // _shareAds();
              log("share");
            },
            icon: SvgPicture.asset(
              IconApp.share,
              width: 24,
              height: 24,
              color: ThemeApp.Foundation_Main_main_500,
            ),
          ),
        ],
      ),
      body:
          // SingleChildScrollView(child: Column(children: [
          //   ],
          // )),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentGeometry.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      itemCount: ads.images.length,
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) {
                            return Container(
                              width: size.width,
                              height: 325,
                              decoration: BoxDecoration(
                                // color: Colors.amberAccent,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(21),
                                  bottomRight: Radius.circular(21),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 7,
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(ads.images[itemIndex]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                      options: CarouselOptions(
                        height: 325,
                        // aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enlargeCenterPage: true,
                        // enlargeFactor: 0.3,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          homeController.currentCarouselIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ads.images.asMap().entries.map((entry) {
                          return Container(
                            // edit
                            // غير قياس
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // edit
                              // غير سماكة
                              border:
                                  homeController.currentCarouselIndex.value ==
                                      entry.key
                                  ? Border.all(
                                      color: ThemeApp.Foundation_Main_main_100,
                                      width: 1.5,
                                    )
                                  : Border.all(style: BorderStyle.none),
                              color:
                                  homeController.currentCarouselIndex.value ==
                                      entry.key
                                  ? ThemeApp.Foundation_Main_main_500
                                  : ThemeApp
                                        .colorCirclesSliderAndStarAndDivider,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextWidget(
                                // firstText: ads.price.toString() + ads.typeCoin + "\,",
                                firstText:
                                    ads.price.toString() +
                                    " " +
                                    ads.typeCoin +
                                    "\, ",
                                secondText: ads.typeService,
                                typographyApp: TypographyApp.Title_larg_Mid,
                              ),
                              Text(
                                ads.title,
                                style:
                                    TypographyApp.Headline_small_Mid.copyWith(
                                      color: ThemeApp.black,
                                    ),
                              ),
                            ],
                          ),
                          Spacer(),
                          // Obx(() {
                          //   return
                          IconButton(
                            onPressed: () {
                              adsController.favorite(ads.id);
                            },
                            icon: SvgPicture.asset(
                              width: 20,
                              height: 20,
                              ads.favorite
                                  ? IconApp.favorite
                                  : IconApp.favoriteBorder,
                              color: ads.favorite
                                  ? ThemeApp.Foundation_Main_main_400
                                  : ThemeApp.black,
                            ),
                          ),
                          // ;
                          // }),
                        ],
                      ),

                      Row(
                        children: [
                          SvgPicture.asset(
                            IconApp.place,
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          // edit
                          Text(
                            "742 Evergreen Terrace, Springfield",
                            style: TypographyApp.Body_mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Secendary_grey_300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: size.width,
                //   height: 8,
                //   color: ThemeApp.Foundation_Secendary_grey_50,
                // ),
                const SpaceBetweenSectionWidget(),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discerption",
                        style: TypographyApp.Title_larg_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_Color_900,
                        ),
                      ),

                      // Obx((){
                      //   return               Text(
                      //                 ads.dictation ?? "",
                      //                 overflow: showMore
                      //                     ? TextOverflow.visible
                      //                     : TextOverflow.ellipsis,
                      //                 maxLines: showMore ? null : 6,
                      //               );
                      //               TextButton(onPressed: (){
                      //                 showMore = !showMore;
                      //               }, child: Text("More"));

                      // })
                      // Obx(() {
                      //   final bool showMore = adsController.showMore.value;
                      //   final String description = ads.dictation ?? "";

                      //   return Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         description,
                      //         style: TypographyApp.Body_mid_Regular,
                      //         overflow: showMore
                      //             ? TextOverflow.visible
                      //             : TextOverflow.ellipsis,
                      //         maxLines: showMore
                      //             ? null
                      //             : 3, // بدل 6 عشان نظهر الـ More أسرع
                      //       ),

                      //       // ✅ إظهار زر More فقط إذا كان النص طويل
                      //       if (description.length > 100) // تقدير بسيط
                      //         TextButton(
                      //           onPressed: () {
                      //             // adsController.toggleShowMore();
                      //             adsController.showMore.value =
                      //                 !adsController.showMore.value;
                      //           },
                      //           style: TextButton.styleFrom(
                      //             padding: EdgeInsets.zero,
                      //             minimumSize: const Size(50, 30),
                      //             alignment: Alignment.centerLeft,
                      //           ),
                      //           child: Text(
                      //             showMore ? "Less" : "More",
                      //             style: TextStyle(
                      //               color: ThemeApp.Foundation_Main_main_500,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ),
                      //     ],
                      //   );
                      // }),
                      // Obx(() {
                      //   final bool showMore = adsController.showMore.value;
                      //   final String description = ads.dictation ?? "";

                      //   return RichText(
                      //     maxLines: showMore ? null : 3,
                      //     overflow: showMore
                      //         ? TextOverflow.visible
                      //         : TextOverflow.ellipsis,
                      //     text: TextSpan(
                      //       // style: typographyApp,
                      //       children: [
                      //         TextSpan(
                      //           text: description,
                      //           style: TextStyle(
                      //             color:
                      //                 // colorFirstText ??
                      //                 ThemeApp.Foundation_Secendary_grey_700,
                      //           ),
                      //         ),
                      //         WidgetSpan(
                      //           child: TextButton(
                      //             onPressed: () {},
                      //             child: Text(
                      //               showMore ? "Less" : "More",
                      //               style: TextStyle(
                      //                 color: ThemeApp.Foundation_Main_main_500,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         // TextSpan(
                      //         //   text: showMore ? "Less" : "More",
                      //         //   style: TextStyle(
                      //         //     color: ThemeApp.Foundation_Main_main_500,
                      //         //     fontWeight: FontWeight.w600,
                      //         //   ),
                      //         //   // style: TextStyle(
                      //         //   //   color:
                      //         //   //       colorSecondText ??
                      //         //   //       ThemeApp.Foundation_Main_main_500,
                      //         //   // ),
                      //         // ),

                      //       ],
                      //     ),
                      //   );
                      // }),
                      ReadMoreText(
                        // ads.dictation!,
                        "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,",
                        style: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Secendary_grey_300,
                        ),
                        // isCollapsed: ,
                        // postDataText: "...",
                        trimMode: TrimMode.Length,
                        // trimLines: 5,
                        trimLength: 200,
                        colorClickableText: ThemeApp.Foundation_Main_main_500,
                        trimCollapsedText: 'More...',
                        trimExpandedText: ' Less',
                        moreStyle: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                        lessStyle: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                        // locale: ,
                        // textScaler: ,
                        delimiter: " ",
                        // annotations: [],
                        // isExpandable: ,
                      ),
                    ],
                  ),
                ),

                // RichText(
                //   text: TextSpan(
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //     children: <InlineSpan>[
                //       // Use <InlineSpan> instead of <TextSpan>
                //       TextSpan(text: 'Please agree to the '),
                //       WidgetSpan(
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 4.0),
                //           child: TextButton(
                //             onPressed: () {
                //               // Handle button press, e.g., navigate to Terms screen
                //               print('Terms of Service pressed!');
                //             },
                //             child: Text(
                //               'Terms of Service',
                //               style: TextStyle(
                //                 color: Colors.blue,
                //                 decoration: TextDecoration.underline,
                //               ),
                //             ),
                //             style: TextButton.styleFrom(
                //               // Optional: adjust padding and alignment to fit inline
                //               minimumSize: Size.zero,
                //               padding: EdgeInsets.zero,
                //               alignment: Alignment.centerLeft,
                //             ),
                //           ),
                //         ),
                //       ),

                //       // TextSpan(text: ' and the '),
                //       // WidgetSpan(
                //       //   child: Padding(
                //       //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
                //       //     child: TextButton(
                //       //       onPressed: () {
                //       //         // Handle button press, e.g., navigate to Policy screen
                //       //         print('Privacy Policy pressed!');
                //       //       },
                //       //       child: Text(
                //       //         'Privacy Policy',
                //       //         style: TextStyle(
                //       //           color: Colors.blue,
                //       //           decoration: TextDecoration.underline,
                //       //         ),
                //       //       ),
                //       //       style: TextButton.styleFrom(
                //       //         minimumSize: Size.zero,
                //       //         padding: EdgeInsets.zero,
                //       //         alignment: Alignment.centerLeft,
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //       // TextSpan(text: '.'),
                //     ],
                //   ),
                // ),
                const SpaceBetweenSectionWidget(),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About this item",
                        style: TypographyApp.Title_larg_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_Color_900,
                        ),
                      ),
                      const SizedBox(
                        height: DimensApp.spaceBetweenTitleAndDetails,
                      ),
                      // edit
                      // from back
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconApp.Balconies,
                            width: 22,
                            height: 22,
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          Text(
                            " Balconies : ",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.black,
                            ),
                          ),
                          Text(
                            "yes",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
                          ),
                          SizedBox(width: 20),
                          SvgPicture.asset(
                            IconApp.Bedrooms,
                            width: 22,
                            height: 22,
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          Text(
                            " Bedrooms : ",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.black,
                            ),
                          ),
                          Text(
                            "yes",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: DimensApp.spaceBetweenTitleAndDetails,
                      ),

                      // edit
                      // from back
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconApp.Furnitures,
                            width: 22,
                            height: 22,
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          Text(
                            " Furnitures : ",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.black,
                            ),
                          ),
                          Text(
                            "yes",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
                          ),
                          SizedBox(width: 20),
                          SvgPicture.asset(
                            IconApp.Status,
                            width: 22,
                            height: 22,
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          Text(
                            " Status : ",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.black,
                            ),
                          ),
                          Text(
                            "New Launch",
                            style: TypographyApp.Title_Mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SpaceBetweenSectionWidget(),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TypographyApp.Title_larg_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_Color_900,
                        ),
                      ),
                      // ElevatedButton(onPressed: (){
                      //   Get.to(MapSample());
                      // }, child: Text("data")),
                      Row(
                        children: [
                          SvgPicture.asset(IconApp.place),
                          // edit
                          Text(ads.place),
                        ],
                      ),
                      Container(
                        width: size.width * 0.9255,
                        height: 329,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ThemeApp.whiteBackground,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: -1,
                              color: Color.fromRGBO(12, 12, 13, 0.05),
                            ),
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: -1,
                              color: Color.fromRGBO(12, 12, 13, 0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: size.width * 0.9255,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),

                              // child: GoogleMap(
                              //   mapType: MapType.hybrid,
                              //   initialCameraPosition: _kGooglePlex,
                              //   onMapCreated: (GoogleMapController controller) {
                              //     _controller.complete(controller);
                              //   },
                              // ),
                            ),
                            Row(
                              children: [
                                // InkWell(
                                //   onTap: () {
                                //     // Get.to(OptionProfileScreen());
                                //   },
                                //   child: Container(
                                //     width: size.width * 0.109,
                                //     height: 48.6,
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: AssetImage(ImageApp.profileImage),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  flex: 15,
                                  child: InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                        isDismissible: true,
                                        enableDrag: true,
                                        BottomSheetPortfolioWidget(),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: size.width * 0.100,
                                      // radius: 36,
                                      // edit
                                      // الصورة ما عم تطلع
                                      backgroundImage: AssetImage(
                                        ImageApp.profileImage,
                                      ),
                                      // backgroundImage: selectedImage != null
                                      //     ? FileImage(selectedImage!)
                                      //     : (user.img!.isNotEmpty ? NetworkImage(user.img!) : null),
                                      // child: user.img!.isEmpty && selectedImage == null
                                      //     ? const Icon(Icons.person, size: 60)
                                      //     : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  flex: 65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mhamad Alshame",
                                        style:
                                            TypographyApp
                                                .Title_Mid_Mid.copyWith(
                                              color: ThemeApp
                                                  .Foundation_Grey_grey_700,
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
                                            color: ThemeApp
                                                .colorIconProfileHomeScreen,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Riyadh – Malaz",
                                            style:
                                                TypographyApp
                                                    .Label_Mid_Regular.copyWith(
                                                  color: ThemeApp
                                                      .Foundation_Secendary_grey_600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                Expanded(
                                  flex: 10,
                                  child: SvgPicture.asset(
                                    IconApp.messages,
                                    width: 29,
                                    height: 29,
                                    color: ThemeApp.Foundation_Main_main_500,
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: SvgPicture.asset(
                                    IconApp.phone,
                                    width: 29,
                                    height: 29,
                                    color: ThemeApp.Foundation_Main_main_500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SpaceBetweenSectionWidget(),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    vertical: 5,
                  ),
                  child: Container(
                    width: size.width * 0.9348,
                    height: 51,
                    alignment: AlignmentGeometry.center,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: BoxBorder.all(
                        color: ThemeApp.Foundation_Main_main_300,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconApp.reviewsRounded,
                          width: 25,
                          height: 25,
                          color: ThemeApp.Foundation_Main_main_300,
                        ),
                        Text(
                          " Rate this Ad",
                          style: TypographyApp.Title_larg_Mid,
                        ),
                      ],
                    ),
                  ),
                ),
                const SpaceBetweenSectionWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // edit
                            // value from back
                            Text(
                              "4.0",
                              style: TypographyApp.H3_Bold.copyWith(
                                color: ThemeApp.Foundation_Main_main_500,
                              ),
                            ),
                            // edit
                            // from back
                            RatingBarIndicator(
                              unratedColor: ThemeApp.Foundation_Main_main_500,
                              // edit
                              // value from back
                              rating: 4,
                              itemBuilder: (context, index) =>
                                  // edit
                                  // value from back
                                  _getStarColor(index, 4.0),

                              itemCount: 5,
                              itemSize: 20,
                              direction: Axis.horizontal,
                            ),
                            // edit
                            // value number from back
                            Text(
                              "Reviews 345.22",
                              style: TypographyApp.Title_Mid_Mid.copyWith(
                                color: ThemeApp.gray_scale_Most_Dark,
                              ),
                            ),
                          ],
                        ),
                        flex: 35,
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          children: [
                            RateStarWidget(
                              percent: 33,
                              numberStar: 5,
                              widthBarPercentage: size.width * 0.437,
                            ),
                            RateStarWidget(
                              percent: 48,
                              numberStar: 4,
                              widthBarPercentage: size.width * 0.437,
                            ),
                            RateStarWidget(
                              percent: 28,
                              numberStar: 3,
                              widthBarPercentage: size.width * 0.437,
                            ),
                            RateStarWidget(
                              percent: 12,
                              numberStar: 2,
                              widthBarPercentage: size.width * 0.437,
                            ),
                            RateStarWidget(
                              percent: 10,
                              numberStar: 1,
                              widthBarPercentage: size.width * 0.437,
                            ),
                          ],
                        ),
                        flex: 65,
                      ),
                    ],
                  ),
                ),
                AppTitleSectionWidget(
                  data: "Top Reviews",
                  typographyAppButton: TypographyApp.Body_mid_Mid,
                  typographyAppTitle: TypographyApp.Title_larg_Mid,
                  // edit
                  // شو لبصفحة يلي بروح عليها
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: size.width * DimensApp.spaceHorizontalScreen,
                    // vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ads.listReview != null && ads.listReview!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ads.listReview!.length,
                              itemBuilder: (context, indexReview) {
                                ReviewModel review =
                                    ads.listReview![indexReview];
                                return Container(
                                  padding: EdgeInsetsGeometry.all(5),
                                  width: size.width * 0.9255,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: BoxBorder.all(
                                      width: 1,
                                      color: ThemeApp
                                          .Foundation_Secendary_Color_Light_hover,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.109,
                                            height: 48.6,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  review.user.image != null
                                                      ? review.user.image!
                                                      : ImageApp.profileImage,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                review.user.firstName +
                                                    " " +
                                                    review.user.lastName,
                                              ),
                                              Text(review.date),
                                            ],
                                          ),
                                          Spacer(),
                                          // edit
                                          Text("4"),
                                          SvgPicture.asset(IconApp.starFill),
                                        ],
                                      ),
                                      Text(review.text),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "No reviews yet",
                                  style:
                                      TypographyApp.Body_mid_Regular.copyWith(
                                        color: ThemeApp
                                            .Foundation_Secendary_grey_400,
                                      ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      bottomNavigationBar: Container(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
          vertical: 0,
        ),
        // height: 60.0,
        // color: Colors.blue,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ThemeApp.Foundation_Main_main_500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Get.bottomSheet(
                    isDismissible: true,
                    enableDrag: true,
                    BottomSheetReviewWidget(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconApp.messages,
                      width: 20,
                      height: 20,
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                    Text(
                      "Chat",
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeApp.Foundation_Main_main_500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Get.bottomSheet(
                    isDismissible: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    BottomSheetAddOrderWidget(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconApp.badgePercent,
                      width: 20,
                      height: 20,
                      color: ThemeApp.Foundation_Main_yellow_50,
                    ),

                    Text(
                      " Make An Offer",
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_yellow_50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //   Future<void> _shareAds() async {
  //     try {
  //       final ads = adsController.adsDetails.value!;

  //       String shareContent =
  //           '''
  // 🏠 *Share ad from Servixa*
  // ═══════════════════════

  // 📌 *${ads.title}*
  // 💰 *Price:* ${ads.price} ${ads.typeCoin}
  // 📍 *Location:* 742 Evergreen Terrace, Springfield
  // 📋 *Type:* ${ads.typeService}

  // 📝 *Description:* ${ads.dictation?.substring(0, ads.dictation!.length > 100 ? 100 : ads.dictation!.length)}${ads.dictation != null && ads.dictation!.length > 100 ? '...' : ''}

  // ⭐ *Rate:* 4.0/5
  // ═══════════════════════
  // For more details:
  // 📱 Download the Servixa app''';

  //       await SharePlus.instance.share(
  //         ShareParams(text: shareContent, subject: 'Share ads: ${ads.title}'),
  //       );

  //       log("Share Done");
  //     } catch (e) {
  //       log("Error in share: $e");
  //     }
  //   }

  // }
}
