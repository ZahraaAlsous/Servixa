import 'package:flutter/material.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';

class ShimmerPolicyWidget extends StatelessWidget {
  const ShimmerPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShimmerLoadingWidget(width: size.width * 0.95),
          ShimmerLoadingWidget(width: size.width * 0.95),
          ShimmerLoadingWidget(width: size.width * 0.95),
          ShimmerLoadingWidget(width: size.width * 0.95),
          ShimmerLoadingWidget(width: size.width * 0.95),
        ],
      ),
    );
  }
}
