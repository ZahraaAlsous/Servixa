import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';

class ShimmerReviewSection extends StatelessWidget {
  final int itemCount;

  const ShimmerReviewSection({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(5),
            width: widthScreen * 0.9255,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: Colors.grey[200]!, 
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShimmerLoadingWidget(
                      width: widthScreen * 0.109,
                      height: 48.6,
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerLoadingWidget(
                          width: widthScreen * 0.3,
                          height: 14,
                        ),
                        const SizedBox(height: 6),
                        ShimmerLoadingWidget(
                          width: widthScreen * 0.2,
                          height: 11,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const ShimmerLoadingWidget(width: 20, height: 12),
                    const SizedBox(width: 4),
                    const ShimmerLoadingWidget(width: 16, height: 15),
                  ],
                ),
                const SizedBox(height: 10),
                ShimmerLoadingWidget(width: widthScreen * 0.8, height: 12),
                const SizedBox(height: 6),
                ShimmerLoadingWidget(width: widthScreen * 0.5, height: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}
