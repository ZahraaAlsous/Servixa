import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';

class ShimmerBusinessAccountList extends StatelessWidget {
  final int itemCount;
  final bool shrinkWrap;
  final bool onlyApproved;
  const ShimmerBusinessAccountList({
    super.key,
    this.itemCount = 4,
    required this.shrinkWrap,
    this.onlyApproved = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: size.width * DimensApp.spaceHorizontalScreen,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onlyApproved
                  ? ShimmerLoadingWidget(width: size.width * 0.4, height: 16)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoadingWidget(
                          width: size.width * 0.4,
                          height: 16,
                        ),
                        ShimmerLoadingWidget(
                          width: size.width * 0.2,
                          height: 14,
                        ),
                      ],
                    ),
              const SizedBox(height: 12),
              ShimmerLoadingWidget(width: size.width * 0.6, height: 14),
            ],
          ),
        );
      },
    );
  }
}
