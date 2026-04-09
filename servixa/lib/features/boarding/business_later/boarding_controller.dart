import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/boarding/presentation_layer/screens/boarding_one_screen.dart';
import 'package:servixa/features/boarding/presentation_layer/screens/boarding_second_screen.dart';

class BoardingController extends GetxController {
  final storage = FlutterSecureStorage();
  RxBool isFirstLunch = true.obs;
  RxInt currentStep = 0.obs;
  final List<Widget> boardingPages = [
    BoardingOneScreen(),
    BoardingSecondScreen(),
  ];

  void checkIfFirstLunch() {
    // bool isFirstLunch = storage.read(key: "isFirstLunch") == "true";
    bool stateIsFirstLunch = storage.read(key: "isFirstLunch") == "true";

    if (stateIsFirstLunch) {
      storage.write(key: "isFirstLunch", value: "false");
      isFirstLunch.value = false;
    }
  }
}
