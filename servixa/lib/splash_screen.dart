import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/bording/presentation_layer/screens/super_bording_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      // edit
      // إذا في token يروح عال home
      // question
      //بال login في زر رجوع ، مو غلط؟
      // Get.offAll(LoginPage());
      Get.offAll(SuperBordingScreen());
      // authService.box.read("token") == null
      //     ? Get.offAll(LoginPage())
      //     : Get.offAll(SuperHomePage());
    });
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(ImageApp.logo),
          width: MediaQuery.of(context).size.width * 0.65,
          height: 143,
          // height: MediaQuery.of(context).size.height * 0.14,
        ),
      ),
    );
  }
}
