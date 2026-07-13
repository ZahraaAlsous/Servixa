

import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';

class ShimmerRateSection extends StatelessWidget {
  const ShimmerRateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
        vertical: 5,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ShimmerLoadingWidget(width: 50, height: 28),
                const SizedBox(height: 8),
                const ShimmerLoadingWidget(width: 90, height: 16),
                const SizedBox(height: 8),
                const ShimmerLoadingWidget(width: 75, height: 14),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 67,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShimmerLoadingWidget(
                        width: widthScreen * 0.437,
                        height: 10,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
