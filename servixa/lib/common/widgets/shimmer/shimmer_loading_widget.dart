import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double width;
  final double? height;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerLoadingWidget({
    super.key,
    required this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      // highlightColor: Colors.grey[100]!,
      highlightColor: ThemeApp.Foundation_Main_main_50.withOpacity(0.5),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors
              .white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class shimmerLoadingList extends StatelessWidget {
  final double height;
  final double heightCard;
  final double widthCard;
  final EdgeInsetsGeometry? margin;

  shimmerLoadingList({
    super.key,
    required this.height,
    required this.heightCard,
    required this.widthCard,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ShimmerLoadingWidget(
            width: widthCard,
            height: heightCard,
            margin: margin,
          );
        },
      ),
    );
  }
}

class shimmerLoadingGrid extends StatelessWidget {
  final double? height;
  final double widthCard;
  final EdgeInsetsGeometry? margin;
  final int numItemInRow;
  final int itemCount;
  final bool shrinkWrap;

  shimmerLoadingGrid({
    super.key,
    this.height,
    required this.widthCard,
    this.margin,
    required this.numItemInRow,
    required this.itemCount,
    required this.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numItemInRow,
        mainAxisSpacing: 32,
        crossAxisSpacing: 32,
        childAspectRatio: 182 / 113,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerLoadingWidget(
          width: widthCard,
          borderRadius: BorderRadius.zero,
        );
      },
    );
  }
}
