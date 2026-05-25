import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/rate/business_later/rate_controller.dart';

class BottomSheetReviewWidget extends StatelessWidget {
  int adId;
  BottomSheetReviewWidget({super.key, required this.adId});
  final _formKey = GlobalKey<FormState>();
  final RateController rateController = Get.put(RateController());
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        rateController.cleanRateFailed();
        log("===============================Screen: Clear Data rateFailed");
        return true;
      },
      child: Container(
        padding: EdgeInsetsGeometry.all(22),
        decoration: BoxDecoration(
          color: ThemeApp.whiteBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        IconApp.reviewsRounded,
                        width: 25,
                        height: 25,
                        color: ThemeApp.Foundation_Main_main_300,
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "Rate this Ad",
                        style: TypographyApp.Title_larg_Mid.copyWith(
                          color: ThemeApp.black,
                        ),
                      ),
                      flex: 8,
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                          rateController.cleanRateFailed();
                        },
                        icon: SvgPicture.asset(
                          IconApp.cancel,
                          width: 32,
                          height: 32,
                          color: ThemeApp.Foundation_Secendary_grey_400,
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                RatingBar.builder(
                  unratedColor: ThemeApp.colorCirclesSliderAndStarAndDivider,
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: ThemeApp.Foundation_Main_main_400,
                  ),
                  onRatingUpdate: (rating) {
                    // _rating = rating;
                    rateController.rate.value = rating.toInt();
                    log(_rating.toString());
                    log(rating.toString());
                    log(rateController.rate.value.toString());
                  },
                ),
                Text(
                  "Rate by clicking on a star",
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_200,
                  ),
                ),
                const SizedBox(height: 10),
                AppTextAreaWidget(
                  controller: rateController.commentController,
                  prefixIcon: IconApp.comment,
                  hintText: "Share your Thought...",
                  validate: Validators.validateNotRequiredButInput,
                ),
                const SizedBox(height: 10),
                Obx(() {
                  if (rateController.isAddRateNow.value) {
                    // return Center(child: CircularProgressIndicator());
                    return LoadingAnimationWidget(message: "Wait please...");
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                            rateController.cleanRateFailed();
                          },
                          child: Text(
                            "Cancel",
                            style: TypographyApp.Body_mid_Mid.copyWith(
                              color: ThemeApp.Foundation_Main_main_500,
                            ),
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
                            if (_formKey.currentState!.validate() &&
                                rateController.validateStars(() {
                                  AppSnackbar.showAlert("select star");
                                })) {
                              rateController.addRate(
                                adId,
                                (message) {
                                  Get.back();
                                  AppSnackbar.showSuccess(message);
                                  rateController.cleanRateFailed();
                                },
                                (e) {
                                  AppSnackbar.showError(e);
                                },
                              );
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TypographyApp.Body_mid_Mid.copyWith(
                              color: ThemeApp.Foundation_Main_yellow_50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
