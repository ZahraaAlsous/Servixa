import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_rate_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_review_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';

class ShimmerAdDetailsWidget extends StatelessWidget {
  const ShimmerAdDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsetsGeometry.symmetric(
          // horizontal: size.width * DimensApp.spaceHorizontalScreen,
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
          vertical: 5,
        ),
        children: [
          ShimmerLoadingWidget(width: double.infinity, height: 325),
          const SizedBox(height: 10),
          Container(
            // margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoadingWidget(width: size.width * 0.4, height: 16),
                const SizedBox(height: 12),
                ShimmerLoadingWidget(width: size.width * 0.6, height: 14),
              ],
            ),
          ),
          const SizedBox(height: 12),

          ShimmerRateSection(),
          const SizedBox(height: 12),
          ShimmerReviewSection(),
          // ShimmerRateWidget(),
          // ShimmerLoadingWidget(
          //   width: double.infinity,
          //   height: 100,
          //   margin: EdgeInsetsGeometry.symmetric(vertical: 10),
          // ),
          // ShimmerLoadingWidget(
          //   width: double.infinity,
          //   height: 100,
          //   margin: EdgeInsetsGeometry.symmetric(vertical: 10),
          // ),
        ],
      ),
    );
  }
}
