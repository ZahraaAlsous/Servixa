import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/boarding/presentation_layer/screens/boarding_one_screen.dart';
import 'package:servixa/features/boarding/presentation_layer/screens/boarding_second_screen.dart';

class BoardingController extends GetxController {
  final storage = FlutterSecureStorage();
  RxBool isFirstLaunch = true.obs;
  RxInt currentStep = 0.obs;
  final List<Widget> boardingPages = [
    BoardingOneScreen(),
    BoardingSecondScreen(),
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  //   checkIfFirstLunch();
  // }

  void checkIfFirstLunch() async {
    String? status = await storage.read(key: "isFirstLaunch");

    if (status == null || status == "true") {
      isFirstLaunch.value = true;
      await storage.write(key: "isFirstLaunch", value: "false");
    } else {
      isFirstLaunch.value = false;
    }
  }
}
