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

          // Container(
          //   height: 20,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   color: Colors.grey[300],
          // ),
          // Container(
          //   height: 20,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   color: Colors.grey[300],
          // ),
          // Container(
          //   height: 20,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   color: Colors.grey[300],
          // ),
          // Container(
          //   height: 20,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   color: Colors.grey[300],
          // ),
        ],
      ),
    );
  }
}
