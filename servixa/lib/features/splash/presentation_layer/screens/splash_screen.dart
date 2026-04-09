import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/splash/business_layer/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: const AssetImage(ImageApp.logo),
          // width: MediaQuery.of(context).size.width * 0.65,
          width: Get.width * 0.65,
          height: 143,
          fit: BoxFit.contain,
          // height: MediaQuery.of(context).size.height * 0.14,
        ),
      ),
    );
  }
}
