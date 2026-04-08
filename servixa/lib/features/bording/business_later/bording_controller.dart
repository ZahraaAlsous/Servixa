import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/bording/presentation_layer/screens/bording_one_screen.dart';
import 'package:servixa/features/bording/presentation_layer/screens/bording_second_screen.dart';

class BordingController extends GetxController {
  final storage = FlutterSecureStorage();
  RxInt currentPageIndex = 0.obs;
  final List<Widget> boardingPages = [
    BordingOneScreen(),
    BordingSecondScreen(),
  ];

  bool isFirstLunch() {
    // bool isFirstLunch = storage.read(key: "isFirstLunch") == "true";
    bool isFirstLunch = storage.read(key: "isFirstLunch") == "true";

    if (isFirstLunch) {
      storage.write(key: "isFirstLunch", value: "false");
    }

    return isFirstLunch;
  }

}
