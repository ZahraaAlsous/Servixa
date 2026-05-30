import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:shimmer/shimmer.dart';

// ✅ Shimmer مخصص ومحاكي تماماً لبطاقات الإعلانات المربعات (GridView Layout)
class ShimmerCardGridView extends StatelessWidget {
  final int itemCount;
  final double widthCard;
  final bool shrinkWrap;

  const ShimmerCardGridView({
    super.key,
    this.itemCount = 6,
    required this.widthCard,
    required this.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * DimensApp.spaceHorizontalScreen,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          width: size.width * widthCard,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. مكان الصورة العلوية
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 126,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. محاكاة نص العنوان (Title)
                    ShimmerLoadingWidget(width: size.width * 0.25, height: 14),
                    const SizedBox(height: 8),
                    // 3. محاكاة سطر الموقع (Location Row)
                    Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        ShimmerLoadingWidget(
                          width: size.width * 0.18,
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 4. محاكاة السعر وزر المفضلة (Price & Favorite)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoadingWidget(
                          width: size.width * 0.15,
                          height: 14,
                        ),
                        const ShimmerLoadingWidget(
                          width: 24,
                          height: 24,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ✅ Shimmer مخصص ومحاكي تماماً لبطاقات الإعلانات المستطيلة (ListView Layout)
class ShimmerCardList extends StatelessWidget {
  final int itemCount;
  final double widthCard;
  final double heightCard;

  const ShimmerCardList({
    super.key,
    this.itemCount = 5,
    required this.widthCard,
    required this.heightCard,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: heightCard,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            width: widthCard,
            height: 118,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. محاكاة الصورة الجانبية الكليب
                ShimmerLoadingWidget(
                  width: size.width * 0.230,
                  height: 95,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(width: 16),
                // 2. تفاصيل الإعلان بالجنب
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // العنوان
                      ShimmerLoadingWidget(
                        width: size.width * 0.35,
                        height: 14,
                      ),
                      const SizedBox(height: 8),
                      // الموقع
                      Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          ShimmerLoadingWidget(
                            width: size.width * 0.2,
                            height: 12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // السعر والمفضلة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerLoadingWidget(
                            width: size.width * 0.18,
                            height: 14,
                          ),
                          const ShimmerLoadingWidget(
                            width: 24,
                            height: 24,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ✅ Shimmer مخصص لبطاقات الإعلانات (ListView الأفقي)
class ShimmerCardHorizontalList extends StatelessWidget {
  final int itemCount;
  final double widthCard;
  final double heightCard;

  const ShimmerCardHorizontalList({
    super.key,
    this.itemCount = 5,
    required this.widthCard,
    required this.heightCard,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: heightCard,
      child: ListView.builder(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            width: widthCard,
            margin: const EdgeInsets.only(right: 12),
            child: Container(
              width: size.width * widthCard,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. مكان الصورة العلوية
                  ShimmerLoadingWidget(
                    width: double.infinity,
                    height: 126,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. محاكاة نص العنوان (Title)
                        ShimmerLoadingWidget(
                          width: size.width * 0.25,
                          height: 14,
                        ),
                        const SizedBox(height: 8),
                        // 3. محاكاة سطر الموقع (Location Row)
                        Row(
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            ShimmerLoadingWidget(
                              width: size.width * 0.18,
                              height: 10,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 4. محاكاة السعر وزر المفضلة (Price & Favorite)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerLoadingWidget(
                              width: size.width * 0.15,
                              height: 14,
                            ),
                            const ShimmerLoadingWidget(
                              width: 24,
                              height: 24,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
