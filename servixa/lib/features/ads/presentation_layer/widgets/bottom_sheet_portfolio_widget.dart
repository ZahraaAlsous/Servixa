// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:servixa/common/widgets/app_card_ads_widget.dart';
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/image_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';
// import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
// import 'package:servixa/features/category/data_layer/models/category_model.dart';
// import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

// class BottomSheetPortfolioWidget extends StatelessWidget {
//   const BottomSheetPortfolioWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return FractionallySizedBox(
//       heightFactor: 2,
//       child: Container(
//         // padding: EdgeInsetsGeometry.all(22),
//         decoration: BoxDecoration(
//           color: ThemeApp.whiteBackground,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: SvgPicture.asset(
//                     IconApp.business,
//                     width: 25,
//                     height: 25,
//                     color: ThemeApp.Foundation_Main_main_300,
//                   ),
//                   flex: 1,
//                 ),
//                 Expanded(
//                   child: Text(
//                     "Portfolio",
//                     style: TypographyApp.Title_larg_Mid.copyWith(
//                       color: ThemeApp.Foundation_Secendary_grey_700,
//                     ),
//                   ),
//                   flex: 8,
//                 ),
//                 Expanded(
//                   child: IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: SvgPicture.asset(
//                       IconApp.cancel,
//                       width: 32,
//                       height: 32,
//                       color: ThemeApp.Foundation_Secendary_grey_400,
//                     ),
//                   ),
//                   flex: 1,
//                 ),
//               ],
//             ),

//             CircleAvatar(
//               radius: 40,
//               // radius: 36,
//               // edit
//               // الصورة ما عم تطلع
//               backgroundImage: AssetImage(ImageApp.profileImageRounded),
//               // backgroundImage: selectedImage != null
//               //     ? FileImage(selectedImage!)
//               //     : (user.img!.isNotEmpty ? NetworkImage(user.img!) : null),
//               // child: user.img!.isEmpty && selectedImage == null
//               //     ? const Icon(Icons.person, size: 60)
//               //     : null,
//             ),

//             Text(
//               "Al Shamel Contracting",
//               style: TypographyApp.Title_Mid_Mid.copyWith(
//                 color: ThemeApp.black,
//               ),
//             ),
//             Row(
//               children: [
//                 SvgPicture.asset(IconApp.Balconies),
//                 Text("Qualified Plus+"),
//               ],
//             ),

//             Divider(color: ThemeApp.Foundation_Secendary_grey_50, thickness: 4),
//             Padding(
//               padding: EdgeInsetsGeometry.symmetric(horizontal: 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Information",
//                     style: TypographyApp.Title_larg_Mid.copyWith(
//                       color: ThemeApp.black,
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(
//                       "Package : ",
//                       style: TypographyApp.Title_Mid_Mid.copyWith(
//                         color: ThemeApp.black,
//                       ),
//                     ),
//                     leading: SvgPicture.asset(IconApp.Balconies),
//                     trailing: Text(
//                       "Platinum Package",
//                       style: TypographyApp.Body_mid_Mid.copyWith(
//                         color: ThemeApp.Foundation_Secendary_grey_300,
//                       ),
//                     ),
//                   ),

//                   ListTile(
//                     title: Text(
//                       "Expires Date : ",
//                       style: TypographyApp.Title_Mid_Mid.copyWith(
//                         color: ThemeApp.black,
//                       ),
//                     ),
//                     leading: SvgPicture.asset(IconApp.clarityDateLine),
//                     trailing: Text(
//                       "30/9/2026",
//                       style: TypographyApp.Body_mid_Mid.copyWith(
//                         color: ThemeApp.Foundation_Secendary_grey_300,
//                       ),
//                     ),
//                   ),

//                   // edit
//                   // إضافة ما تبقى من بيست إذا بدنا ياهون
//                   Text(
//                     "My Ads",
//                     style: TypographyApp.Title_larg_Mid.copyWith(
//                       color: ThemeApp.black,
//                     ),
//                   ),

//                   SizedBox(
//                     height: 300,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 5,
//                       itemBuilder: (context, indexAds) {
//                         return AppCardAdsWidget(
//                           ads: AdsModel(
//                             id: 1,
//                             title: "title",
//                             place: "place",
//                             image: ImageApp.bording1,
//                             images: [ImageApp.slidAds],
//                             favorite: false,
//                             price: 500,
//                             typeCoin: "typeCoin",
//                             typeService: "typeService",
//                             status: "status",
//                             category: CategoryModel(
//                               id: 1,
//                               name: "name",
//                               icon: IconApp.adsFill,
//                               subCategories: [
//                                 SubCategoryModel(
//                                   id: 1,
//                                   name: "name",
//                                   icon: IconApp.business,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           widthCard: size.width * 0.367,
//                           isGridView: true,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_card_ads_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

class BottomSheetPortfolioWidget extends StatelessWidget {
  const BottomSheetPortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: ThemeApp.whiteBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconApp.business,
                  width: 25,
                  height: 25,
                  color: ThemeApp.Foundation_Main_main_300,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Portfolio",
                    style: TypographyApp.Title_larg_Mid.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    IconApp.cancel,
                    width: 32,
                    height: 32,
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
              ],
            ),
          ),

          // المحتوى القابل للتمرير
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(ImageApp.profileImageRounded),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Al Shamel Contracting",
                    style: TypographyApp.Title_Mid_Mid.copyWith(
                      color: ThemeApp.black,
                    ),
                  ),
                  SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconApp.Balconies,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 5),
                      Text("Qualified Plus+"),
                    ],
                  ),

                  Divider(
                    color: ThemeApp.Foundation_Secendary_grey_50,
                    thickness: 4,
                    height: 30,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Information",
                          style: TypographyApp.Title_larg_Mid.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconApp.Balconies,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Package :",
                                  style: TypographyApp.Title_Mid_Mid.copyWith(
                                    color: ThemeApp.black,
                                  ),
                                ),
                              ),
                              Text(
                                "Platinum Package",
                                style: TypographyApp.Body_mid_Mid.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_300,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconApp.clarityDateLine,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Expires Date :",
                                  style: TypographyApp.Title_Mid_Mid.copyWith(
                                    color: ThemeApp.black,
                                  ),
                                ),
                              ),
                              Text(
                                "30/9/2026",
                                style: TypographyApp.Body_mid_Mid.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_300,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        Text(
                          "My Ads",
                          style: TypographyApp.Title_larg_Mid.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                        SizedBox(height: 10),

                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, indexAds) {
                              return Container(
                                width: size.width * 0.367,
                                margin: EdgeInsets.only(right: 12),
                                child: 
                                AppCardAdsWidget(
                                  ads:
                                   AdsModel(
                                    id: indexAds + 1,
                                    title: "Title $indexAds",
                                    place: "Place $indexAds",
                                    image: ImageApp.bording1,
                                    images: [ImageApp.slidAds],
                                    favorite: false,
                                    price: 500 + (indexAds * 100),
                                    typeCoin: "SAR",
                                    typeService: "Service",
                                    status: "Active",
                                    category: CategoryModel(
                                      id: 1,
                                      name: "Category",
                                      icon: IconApp.adsFill,
                                      subCategories: [
                                        SubCategoryModel(
                                          id: 1,
                                          name: "Sub Category",
                                          icon: IconApp.business,
                                        ),
                                      ],
                                    ),
                                  ),
                                  widthCard: size.width * 0.367,
                                  isGridView: true,
                                ),
                              )
                              ;
                            },
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
