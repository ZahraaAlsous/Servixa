import 'package:flutter/material.dart';

class InternetConnectionErrorWidget extends StatelessWidget {
  final void Function()? onPressed;
   InternetConnectionErrorWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('No internet connection or server error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  // onPressed: () => controller.fetchHomeData(), 

                  onPressed: onPressed,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
  }
}