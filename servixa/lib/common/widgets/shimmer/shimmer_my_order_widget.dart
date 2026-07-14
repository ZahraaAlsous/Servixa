import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';

class ShimmerMyOrderCardList extends StatelessWidget {
  final int itemCount;
  const ShimmerMyOrderCardList({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 231,
            width: size.width * 0.8976,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 65, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.3, height: 14),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 45, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.25, height: 14),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 55, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.2, height: 14),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(width: 50, height: 14),
                    ShimmerLoadingWidget(width: size.width * 0.4, height: 14),
                  ],
                ),
                const Spacer(),
                const Divider(thickness: 2, color: Colors.transparent),
                Center(
                  child: ShimmerLoadingWidget(
                    width: size.width * 0.739,
                    height: 29,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
