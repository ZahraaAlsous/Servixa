import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';

class ShimmerReceivedOrderCardList extends StatelessWidget {
  final int itemCount;
  const ShimmerReceivedOrderCardList({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 231, // نفس الارتفاع المحدد بالكرت الأصلي
            width: size.width * 0.8976, // نفس العرض
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 30,
            ), // الـ Padding الأصلي للكرت المستلم
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Column(
              children: [
                // أسطر البيانات الأربعة (Request Date, Service, Name, Phone/Email)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 90, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.25, height: 14),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 60, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.3, height: 14),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 50, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.35, height: 14),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 55, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.25, height: 14),
                  ],
                ),
                const Spacer(),
                const Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.transparent,
                ),
                // محاكاة الزرين السفليين المتجاورين (Accept / Decline)
                Row(
                  children: [
                    Expanded(
                      child: ShimmerLoadingWidget(
                        width: double.infinity,
                        height: 36,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ShimmerLoadingWidget(
                        width: double.infinity,

                        height: 36,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
