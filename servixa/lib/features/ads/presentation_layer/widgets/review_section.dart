import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/shimmer/shimmer_review_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/rate/business_later/rate_controller.dart';
import 'package:servixa/features/rate/data_layer/models/rate_model.dart';

class ReviewSection extends StatelessWidget {
  ReviewSection({super.key});
  final RateController rateController = Get.put(RateController());

  @override
  Widget build(BuildContext context) {
    final widthScreen = Get.width;

    return Obx(() {
      if (rateController.isLoadingRateNow.value) {
        // return Center(child: CircularProgressIndicator());
        // return LoadingAnimationWidget(message: "Loading reviews...".tr());
        return ShimmerReviewSection();
      }
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(
          // horizontal: size.width * DimensApp.spaceHorizontalScreen,
          horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
          // vertical: 10,
        ),
        child:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            // ads.listReview != null && ads.listReview!.isNotEmpty
            rateController.ratesReview.value != null &&
                rateController.ratesReview.value!.ratings.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                // itemCount: ads.listReview!.length,
                itemCount: rateController.ratesReview.value!.ratings.length,
                itemBuilder: (context, indexReview) {
                  RateModel review =
                      rateController.ratesReview.value!.ratings[indexReview];
                  return Container(
                    padding: EdgeInsetsGeometry.all(5),
                    margin: EdgeInsetsGeometry.only(bottom: 5),
                    // width: size.width * 0.9255,
                    width: widthScreen * 0.9255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: BoxBorder.all(
                        width: 1,
                        color: ThemeApp.Foundation_Secendary_Color_Light_hover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   width: widthScreen * 0.109,
                            //   height: 48.6,
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       image: AssetImage(
                            //         review.user.image != null
                            //             ? review.user.image!
                            //             : ImageApp.profileImage,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child:
                                  // FadeInImage(
                                  //   width: widthScreen * 0.109,
                                  //   height: 48.6,
                                  //   fit: BoxFit.cover,
                                  //   placeholder: AssetImage(ImageApp.placeholder),
                                  //   image: review.user.image != null
                                  //       ? NetworkImage(review.user.image!)
                                  //       : AssetImage(ImageApp.profileImage),
                                  //   imageErrorBuilder:
                                  //       (context, error, stackTrace) {
                                  //         return Container(
                                  //           width: widthScreen * 0.109,
                                  //           height: 48.6,
                                  //           decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(
                                  //               100,
                                  //             ),
                                  //             color: ThemeApp
                                  //                 .Foundation_Secendary_grey_100,
                                  //           ),
                                  //           child: const Icon(
                                  //             Icons.broken_image,
                                  //             size: 30,
                                  //             color: Colors.grey,
                                  //           ),
                                  //         );
                                  //       },
                                  // ),
                                  review.user.image != null
                                  ? CircleAvatar(
                                      child: CachedNetworkImage(
                                        imageUrl: review.user.image!,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              ImageApp.placeholder,
                                              fit: BoxFit.cover,
                                            ),
                                        fit: BoxFit.cover,
                                        width: widthScreen * 0.109,
                                        height: 48.6,
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            width: widthScreen * 0.109,
                                            height: 48.6,
                                            color: ThemeApp
                                                .Foundation_Secendary_grey_100,
                                            child: const Icon(
                                              Icons.broken_image,
                                              size: 30,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                        fadeInDuration: Duration(seconds: 1),
                                        fadeOutDuration: Duration(seconds: 1),
                                        placeholderFadeInDuration: Duration(
                                          seconds: 1,
                                        ),
                                      ),
                                    )
                                  : Image(
                                      image: AssetImage(ImageApp.profileImage),
                                      width: widthScreen * 0.109,
                                      height: 48.6,
                                      fit: BoxFit.cover,
                                    ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.user.firstName +
                                      " " +
                                      review.user.lastName,
                                  style: TypographyApp.Title_Mid_Mid.copyWith(
                                    color: ThemeApp
                                        .Foundation_Secendary_Color_Normal,
                                  ),
                                ),
                                // Text(review.date),
                                Text(
                                  review.createdAt,
                                  style: TypographyApp.Label_Mid_Mid.copyWith(
                                    color: ThemeApp.gray_scale_Most_Dark,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            // edit
                            Text(
                              review.rate.toString(),
                              style: TypographyApp.Label_Mid_Mid.copyWith(
                                color: ThemeApp.gray_scale_Most_Dark,
                              ),
                            ),
                            SvgPicture.asset(
                              IconApp.starFill,
                              width: 16,
                              height: 15,
                            ),
                          ],
                        ),
                        if (review.comment != null)
                          Text(
                            review.comment!,
                            style: TypographyApp.Label_Mid_Regular.copyWith(
                              color: ThemeApp.gray_scale_Most_Dark,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "No reviews yet".tr(),
                    style: TypographyApp.Body_mid_Regular.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_400,
                    ),
                  ),
                ),
              ),
        // ],
        // ),
      );
    });
  }
}
