import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_dialogs.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/favoite_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/favorite_ad/business_layer/favorite_controller.dart';

// class AppCardAdsWidget extends StatelessWidget {
//   final AdsController adsController = Get.put(AdsController());
//   final AddAdsController addAdsController = Get.put(AddAdsController());
//   final FavoriteController favoriteController = Get.put(FavoriteController());
//   final AuthController authController = Get.find<AuthController>();
//   // String assetName;
//   // bool favorit;
//   // int adsId;
//   AdsModel ads;
//   double widthCard;
//   final bool isGridView;
//   void Function()? onTap;
//   bool isSearchCard;
//   bool isViewAll;
//   bool isMyAdd;
//   AppCardAdsWidget({
//     super.key,
//     // required this.assetName,
//     // required this.favorit,
//     // required this.adsId,
//     required this.ads,
//     required this.widthCard,
//     required this.isGridView,
//     this.onTap,
//     this.isSearchCard = false,
//     this.isViewAll = false,
//     this.isMyAdd = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: onTap,
//       child: isGridView ? _buildGridLayout(size) : _buildListLayout(size),
//     );
//   }

//   Widget _buildGridLayout(Size size) {
//     return Container(
//       width: size.width * widthCard,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),

//         border: BoxBorder.all(
//           color: ThemeApp.Foundation_Secendary_grey_50,
//           width: 1,
//         ),
//       ),

//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Stack(
//             children: [
//               // Container(
//               //   width: size.width,
//               //   height: 126,
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.only(
//               //       topLeft: Radius.circular(8),
//               //       topRight: Radius.circular(8),
//               //     ),
//               //     image: DecorationImage(
//               //       image: NetworkImage(ads.image),
//               //       fit: BoxFit.cover,
//               //     ),
//               //   ),
//               // ),
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(8),
//                 ),
//                 child: FadeInImage(
//                   image: NetworkImage(ads.image),
//                   placeholder: const AssetImage(ImageApp.placeholder),
//                   fit: BoxFit.cover,
//                   width: size.width,
//                   height: 126,
//                   imageErrorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       width: size.width,
//                       height: 126,
//                       color: ThemeApp.Foundation_Secendary_grey_100,
//                       child: const Icon(
//                         Icons.broken_image,
//                         size: 30,
//                         color: Colors.grey,
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               isMyAdd
//                   ?
//                     // Row(
//                     //     children: [
//                     //       IconButton(
//                     //         onPressed: () {
//                     //           addAdsController.initialFailedEditAd(ads);
//                     //           Get.to(SuperAdsScreen());
//                     //         },
//                     //         icon: SvgPicture.asset(
//                     //           IconApp.edit,
//                     //           color: ThemeApp.Foundation_Main_main_500,
//                     //         ),
//                     //       ),
//                     //       Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         adsController.deleteAd(ads.id, () {
//                           AppSnackbar.showSuccess("Ad removed successfully");
//                         }, (e) => AppSnackbar.showError(e));
//                       },
//                       icon: Icon(
//                         Icons.delete_rounded,
//                         color: ThemeApp.Foundation_Statue_Red,
//                       ),
//                     )
//                   // ,
//                   //   ],
//                   // )
//                   : SizedBox(),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsetsGeometry.only(
//               right: 8,
//               left: 8,
//               top: 8,
//               // bottom: 8,
//             ),
//             child: Column(
//               // mainAxisAlignment:MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   // "SPR Claw Hammers",
//                   ads.title,
//                   style: TypographyApp.text_button_home_page.copyWith(
//                     color: ThemeApp.black,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.place_outlined),
//                     Expanded(
//                       child: Text(
//                         // "Riyadh – Malaz",
//                         ads.place ?? "place",
//                         style: TypographyApp.Label_Mid_Regular.copyWith(
//                           color: ThemeApp.Foundation_Secendary_grey_300,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         // "500 SAK",
//                         ads.price.toString() + " " + ads.typeCoin,
//                         maxLines: 1,
//                         style: TypographyApp.Body_mid_Mid.copyWith(
//                           color: ThemeApp.Foundation_Main_main_500,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                     // Spacer(),
//                     IconButton(
//                       onPressed: authController.isLoggedIn.value
//                           ? () {
//                               // adsController.favorite(ads.id);
//                               favoriteController.addToFavorite(ads.id, (e) {
//                                 AppSnackbar.showError(e);
//                               });
//                             }
//                           : () {
//                               AppSnackbar.showAlert("You must be logged in");
//                             },
//                       icon: SvgPicture.asset(
//                         ads.favorite
//                             ? IconApp.favorite
//                             : IconApp.favoriteBorder,
//                         color: ads.favorite
//                             ? ThemeApp.Foundation_Main_main_400
//                             : ThemeApp.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListLayout(Size size) {
//     return Container(
//       width: size.width * widthCard,
//       height: 118,
//       padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 19),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(33),
//         color: ThemeApp.whiteBackground,
//         border: isSearchCard || isViewAll
//             ? BoxBorder.all(
//                 color: ThemeApp.Foundation_Secendary_grey_50,
//                 width: 1,
//               )
//             : null,
//         boxShadow: isSearchCard
//             ? [
//                 BoxShadow(
//                   offset: const Offset(0, 16),
//                   blurRadius: 32,
//                   spreadRadius: -4,
//                   color: Color(0xff0C0C0D1A).withOpacity(0.10),
//                 ),
//                 BoxShadow(
//                   offset: const Offset(0, 4),
//                   blurRadius: 4,
//                   spreadRadius: -4,
//                   color: Color(0xff0C0C0D1A).withOpacity(0.05),
//                 ),
//               ]
//             : null,
//       ),

//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Container(
//           //   width: size.width * 0.230,
//           //   height: 95,
//           //   decoration: BoxDecoration(
//           //     borderRadius: BorderRadius.circular(8),
//           //     image: DecorationImage(
//           //       image: AssetImage(ads.image),
//           //       fit: BoxFit.cover,
//           //     ),
//           //   ),
//           // ),
//           // Container(
//           //   width: size.width * 0.230,
//           //   height: 95,
//           //   decoration: BoxDecoration(
//           //     borderRadius: BorderRadius.circular(8),
//           //     // image: DecorationImage(
//           //     //   image: AssetImage(ads.image),
//           //     //   fit: BoxFit.cover,
//           //     // ),
//           //   ),
//           //   child:
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: FadeInImage(
//               image: NetworkImage(ads.image),
//               placeholder: const AssetImage(ImageApp.placeholder),
//               fit: BoxFit.cover,
//               width: size.width * 0.230,
//               height: 95,
//               imageErrorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   width: size.width * 0.230,
//                   height: 95,
//                   color: ThemeApp.Foundation_Secendary_grey_100,
//                   child: const Icon(
//                     Icons.broken_image,
//                     size: 30,
//                     color: Colors.grey,
//                   ),
//                 );
//               },
//             ),
//           ),

//           // ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   ads.title,
//                   style: TypographyApp.Body_mid_Mid.copyWith(
//                     color: ThemeApp.black,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       IconApp.place,
//                       width: 16,
//                       height: 16,
//                       color: ThemeApp.Foundation_Main_main_500,
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       ads.place ?? "place",
//                       style: TypographyApp.Body_mid_Regular.copyWith(
//                         color: ThemeApp.Foundation_Secendary_grey_300,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       ads.price.toString() + " " + ads.typeCoin,
//                       style: TypographyApp.Title_Mid_Mid.copyWith(
//                         color: ThemeApp.Foundation_Main_main_500,
//                       ),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: authController.isLoggedIn.value
//                           ? () {
//                               // adsController.favorite(ads.id);
//                               favoriteController.addToFavorite(ads.id, (e) {
//                                 AppSnackbar.showError(e);
//                               });
//                             }
//                           : () {
//                               AppSnackbar.showAlert("You must be logged in");
//                             },
//                       icon: SvgPicture.asset(
//                         ads.favorite
//                             ? IconApp.favorite
//                             : IconApp.favoriteBorder,
//                         color: ads.favorite
//                             ? ThemeApp.Foundation_Main_main_400
//                             : ThemeApp.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AppCardAdsWidget extends StatelessWidget {
  final AdsController adsController = Get.put(AdsController());
  final AddAdsController addAdsController = Get.put(AddAdsController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final AuthController authController = Get.find<AuthController>();

  final AdsModel ads;
  final double widthCard;
  final bool isGridView;
  final void Function()? onTap;
  final bool isSearchCard;
  final bool isViewAll;
  final bool isMyAdd;

  AppCardAdsWidget({
    super.key,
    required this.ads,
    required this.widthCard,
    required this.isGridView,
    this.onTap,
    this.isSearchCard = false,
    this.isViewAll = false,
    this.isMyAdd = false,
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
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: FadeInImage(
                  image: NetworkImage(ads.image),
                  placeholder: const AssetImage(ImageApp.placeholder),
                  fit: BoxFit.cover,
                  width: size.width,
                  height: 126,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size.width,
                      height: 126,
                      color: ThemeApp.Foundation_Secendary_grey_100,
                      child: const Icon(
                        Icons.broken_image,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              isMyAdd
                  ? IconButton(
                      onPressed: () {
                        // adsController.deleteAd(ads.id, () {
                        //   AppSnackbar.showSuccess("Ad removed successfully");
                        // }, (e) => AppSnackbar.showError(e));
                        AppDialogs.showConfirmation(
                          title: "Confirm deletion",
                          message: "Are you sure you want to delete this ad?",
                          onConfirm: () {
                            adsController.deleteAd(ads.id, () {
                              Get.back();
                              AppSnackbar.showSuccess(
                                "Ad removed successfully",
                              );
                            }, (e) => AppSnackbar.showError(e));
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: ThemeApp.Foundation_Statue_Red,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ads.title,
                  style: TypographyApp.text_button_home_page.copyWith(
                    color: ThemeApp.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.place_outlined),
                    Expanded(
                      child: Text(
                        ads.place ?? "place",
                        style: TypographyApp.Label_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Secendary_grey_300,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${ads.price} ${ads.typeCoin}",
                        maxLines: 1,
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // هنا تم استدعاء الودجت المتحرك الجديد لشبكة العرض
                    FavoriteAnimatedButton(
                      isFavorite: ads.favorite,
                      onTap: authController.isLoggedIn.value
                          ? () {
                              favoriteController.addToFavorite(ads.id, (e) {
                                AppSnackbar.showError(e);
                              });
                            }
                          : () {
                              AppSnackbar.showAlert("You must be logged in");
                            },
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: ThemeApp.whiteBackground,
        border: isSearchCard || isViewAll
            ? BoxBorder.all(
                color: ThemeApp.Foundation_Secendary_grey_50,
                width: 1,
              )
            : null,
        // boxShadow: isSearchCard
        //     ? [
        //         BoxShadow(
        //           offset: const Offset(0, 16),
        //           blurRadius: 32,
        //           spreadRadius: -4,
        //           color: const Color(0xff0C0C0D1A).withOpacity(0.10),
        //         ),
        //         BoxShadow(
        //           offset: const Offset(0, 4),
        //           blurRadius: 4,
        //           spreadRadius: -4,
        //           color: const Color(0xff0C0C0D1A).withOpacity(0.05),
        //         ),
        //       ]
        //     : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage(
              image: NetworkImage(ads.image),
              placeholder: const AssetImage(ImageApp.placeholder),
              fit: BoxFit.cover,
              width: size.width * 0.230,
              height: 95,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  width: size.width * 0.230,
                  height: 95,
                  color: ThemeApp.Foundation_Secendary_grey_100,
                  child: const Icon(
                    Icons.broken_image,
                    size: 30,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
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
                    const SizedBox(width: 5),
                    Text(
                      ads.place ?? "place",
                      style: TypographyApp.Body_mid_Regular.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_300,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${ads.price} ${ads.typeCoin}",
                      style: TypographyApp.Title_Mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                    const Spacer(),
                    // هنا تم استدعاء الودجت المتحرك الجديد للقائمة
                    FavoriteAnimatedButton(
                      isFavorite: ads.favorite,
                      onTap: authController.isLoggedIn.value
                          ? () {
                              favoriteController.addToFavorite(ads.id, (e) {
                                AppSnackbar.showError(e);
                              });
                            }
                          : () {
                              AppSnackbar.showAlert("You must be logged in");
                            },
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
