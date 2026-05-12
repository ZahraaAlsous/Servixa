import 'dart:developer';

import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/home/data_layer/models/image_slider_model.dart';
import 'package:servixa/features/home/data_layer/sourses/home_service.dart';

class HomeController extends GetxController {
  final HomeService homeService = HomeService();
  RxBool isLoadingSlider = false.obs;
  RxInt currentCarouselIndex = 0.obs;
  RxList<ImageSliderModel> sliders = <ImageSliderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getImageSliders();
  }

  Future<void> getImageSliders() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: getImageSliders IN");
      isLoadingSlider.value = true;
      List<ImageSliderModel> fetchedSliders = await homeService
          .getImageSliders();
      sliders.value = fetchedSliders;
    } catch (e) {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller: getImageSliders ERROR");
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>The error is: ${e.toString()}");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingSlider.value = false;
    }
  }
}
