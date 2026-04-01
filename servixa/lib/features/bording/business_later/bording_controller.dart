import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/bording/presentation_layer/screens/bording_one_screen.dart';
import 'package:servixa/features/bording/presentation_layer/screens/bording_second_screen.dart';

class BordingController extends GetxController {
  RxInt currentPageIndex = 0.obs;
  final List<Widget> boardingPages = [
    BordingOneScreen(),
    BordingSecondScreen(),
  ];
}
// import 'package:get/get.dart' hide Trans;

// class BordingController extends GetxController {
//   RxInt currentPageIndex = 0.obs;

//   // عدد الصفحات
//   final int totalPages = 2;

//   // الانتقال للصفحة التالية
//   void nextPage() {
//     if (currentPageIndex.value < totalPages - 1) {
//       currentPageIndex.value++;
//     } else {
//       // إذا كانت آخر صفحة، انتقل إلى الشاشة الرئيسية
//       Get.offAllNamed('/home'); // أو أي مسار تريد
//     }
//   }

//   // العودة للصفحة السابقة
//   void previousPage() {
//     if (currentPageIndex.value > 0) {
//       currentPageIndex.value--;
//     }
//   }

//   // هل هذه أول صفحة؟
//   bool get isFirstPage => currentPageIndex.value == 0;

//   // هل هذه آخر صفحة؟
//   bool get isLastPage => currentPageIndex.value == totalPages - 1;
// }
