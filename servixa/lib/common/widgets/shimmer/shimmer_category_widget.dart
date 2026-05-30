import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';

// ✅ Shimmer مخصص للفئات (Categories)
class ShimmerCategoriesGrid extends StatelessWidget {
  final int itemCount;

  const ShimmerCategoriesGrid({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 2,
        childAspectRatio: 120 / 84,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerLoadingWidget(
          width: 120,
          height: 84,
          borderRadius: BorderRadius.circular(41),
        );
      },
    );
  }
}

class ShimmerCategoriesList extends StatelessWidget {
  final int itemCount;
  final double height;

  const ShimmerCategoriesList({
    super.key,
    this.itemCount = 6,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ShimmerLoadingWidget(
            width: size.width * 0.279,
            height: 100,
            borderRadius: BorderRadius.circular(41),
            margin: EdgeInsetsGeometry.symmetric(
              // edit
              // إذا ضفت padding أو margin للصفحة كاملة  ما يتأثر الطرف الأول من الناصر مع طرف الصفحة
              horizontal: size.width * (DimensApp.gapBetweenCategoryCard / 2),
            ),
          );
        },
      ),
    );
  }
}
