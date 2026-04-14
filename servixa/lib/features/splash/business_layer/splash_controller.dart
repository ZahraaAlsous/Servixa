import 'package:get/get.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/login_page.dart';
import 'package:servixa/features/boarding/business_later/boarding_controller.dart';
import 'package:servixa/features/boarding/presentation_layer/screens/super_boarding_screen.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class SplashController extends GetxController {
  BoardingController boardingController = Get.put(BoardingController());
  AuthController authController = Get.put(AuthController());
  @override
  void onInit() {
    super.onInit();
    boardingController.checkIfFirstLunch();
    authController.checkLoginStatus();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 5));

    final boardingController = Get.put(BoardingController());
    final authController = Get.put(AuthController());

    if (boardingController.isFirstLaunch.value) {
      Get.offAll(() => SuperBoardingScreen());
    } else {
      if (authController.isLoggedIn.value) {
        Get.offAll(() => const SuperHomeScreen());
      } else {
        Get.offAll(() => LoginPage());
      }
    }
  }
}
