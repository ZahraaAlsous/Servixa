

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
          // القسم الأيسر: المعدل، النجوم، وعدد التقييمات
          Expanded(
            flex: 33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // نص رقم التقييم الإجمالي (مثال: 4.5)
                const ShimmerLoadingWidget(width: 50, height: 28),
                const SizedBox(height: 8),
                // شريط النجوم (خمس نجوم متحركة)
                const ShimmerLoadingWidget(width: 90, height: 16),
                const SizedBox(height: 8),
                // نص عدد المراجعات السفلي
                const ShimmerLoadingWidget(width: 75, height: 14),
              ],
            ),
          ),
          const SizedBox(width: 6),
          // القسم الأيمن: أسطر نسب النجوم الخمسة
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
                      // // رقم النجمة
                      // const ShimmerLoadingWidget(width: 10, height: 12),
                      // const SizedBox(width: 4),
                      // // شكل النجمة الصغيرة
                      // const ShimmerLoadingWidget(width: 12, height: 12),
                      // const SizedBox(width: 8),
                      // شريط النسبة المئوية التقدمي (بناءً على المعادلة المذكورة في الوجت الخاصة بك)
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
