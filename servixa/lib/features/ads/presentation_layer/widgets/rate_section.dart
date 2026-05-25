import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/rate/business_later/rate_controller.dart';
import 'package:servixa/features/rate/data_layer/models/statistics_model.dart';
import 'package:servixa/features/rate/presentation_layer/widgets/rate_star_widget.dart';

class RateSection extends StatelessWidget {
  RateSection({super.key});
  final RateController rateController = Get.put(RateController());

  @override
  Widget build(BuildContext context) {
    final widthScreen = Get.width;

    return Obx(() {
      if (rateController.isLoadingRateNow.value) {
        // Center(child: CircularProgressIndicator());
     return   LoadingAnimationWidget(message: "Loading rate...");
      }
      if (rateController.ratesReview.value == null) {
        return const Center(child: Text("No ratings available"));
      }
      StatisticsModel rate = rateController.ratesReview.value!.statistics;

      return Padding(
        padding: EdgeInsets.symmetric(
          // horizontal:   size.width * DimensApp.spaceHorizontalScreen,
          horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 33,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "4.0",
                    rate.averageRating.toDouble().toString(),
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
                        _getStarColor(index, rate.averageRating.toDouble()),

                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                  ),
                  Text(
                    "Reviews ${rate.totalRatings.toString()}",
                    style: TypographyApp.Title_Mid_Mid.copyWith(
                      color: ThemeApp.gray_scale_Most_Dark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 67,
              child: Column(
                children: [
                  RateStarWidget(
                    percent: rate.ratingPercentagesFive,
                    numberStar: 5,
                    // widthBarPercentage: size.width * 0.437,
                    widthBarPercentage: widthScreen * 0.437,
                  ),
                  RateStarWidget(
                    percent: rate.ratingPercentagesFour,
                    numberStar: 4,
                    // widthBarPercentage: size.width * 0.437,
                    widthBarPercentage: widthScreen * 0.437,
                  ),
                  RateStarWidget(
                    percent: rate.ratingPercentagesThree,
                    numberStar: 3,
                    // widthBarPercentage: size.width * 0.437,
                    widthBarPercentage: widthScreen * 0.437,
                  ),
                  RateStarWidget(
                    percent: rate.ratingPercentagesTwo,
                    numberStar: 2,
                    // widthBarPercentage: size.width * 0.437,
                    widthBarPercentage: widthScreen * 0.437,
                  ),
                  RateStarWidget(
                    percent: rate.ratingPercentagesOne,
                    numberStar: 1,
                    // widthBarPercentage: size.width * 0.437,
                    widthBarPercentage: widthScreen * 0.437,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
}
