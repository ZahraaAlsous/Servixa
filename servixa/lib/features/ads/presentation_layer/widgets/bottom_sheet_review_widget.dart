import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';

class BottomSheetReviewWidget extends StatelessWidget {
  BottomSheetReviewWidget({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
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
            ),
            Expanded(
              flex: 2,
              child: RatingBar.builder(
                unratedColor: ThemeApp.colorCirclesSliderAndStar,
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: ThemeApp.Foundation_Main_main_400),
                onRatingUpdate: (rating) {
                  _rating = rating;
                  log(_rating.toString());
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Rate by clicking on a star",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_200,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: AppTextAreaWidget(
                controller: reviewController,
                prefixIcon: IconApp.comment,
                hintText: "Share your Thought...",
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
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
                        if (_formKey.currentState!.validate()) {
                          // edit
                          // تابع لإضافة تعليق
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
