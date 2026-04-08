import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/bording/presentation_layer/screens/bording_one_screen.dart';
import 'package:servixa/features/bording/presentation_layer/screens/bording_second_screen.dart';

class BordingController extends GetxController {
  final storage = FlutterSecureStorage();
  RxBool isFirstLunch = true.obs;
  RxInt currentPageIndex = 0.obs;
  final List<Widget> boardingPages = [
    BordingOneScreen(),
    BordingSecondScreen(),
  ];

  void checkIfFirstLunch () {
    // bool isFirstLunch = storage.read(key: "isFirstLunch") == "true";
    bool stateIsFirstLunch = storage.read(key: "isFirstLunch") == "true";

    if (stateIsFirstLunch) {
      storage.write(key: "isFirstLunch", value: "false");
      isFirstLunch.value = false;
    }
  }

}
