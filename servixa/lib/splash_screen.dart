import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/login_page.dart';
import 'package:servixa/features/bording/business_later/bording_controller.dart';
import 'package:servixa/features/bording/presentation_layer/screens/super_bording_screen.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class SplashScreen extends StatelessWidget {
  final BordingController bordingController = Get.put(BordingController());
  final AuthController authController = Get.put(AuthController());
  final storage = FlutterSecureStorage();
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      // edit
      // إذا في token يروح عال home
      // question
      //بال login في زر رجوع ، مو غلط؟
      // Get.offAll(LoginPage());
      bordingController.isFirstLunch()
          ? Get.offAll(SuperBordingScreen())
          // : (authController.isLoggedIn.value
          : (authController.isLoggedIn.value
                ? Get.offAll(SuperHomeScreen())
                : Get.offAll(LoginPage()));
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
