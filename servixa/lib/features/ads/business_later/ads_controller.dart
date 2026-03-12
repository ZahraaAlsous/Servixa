import 'package:get/get.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/core/const/image_app.dart';

class AdsController extends GetxController {
  RxBool showMore = false.obs;
  RxList<AdsModel> adsList = <AdsModel>[].obs;
  Rx<AdsModel?> adsDetails = Rx<AdsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getAds();
  }

  void getAds() {
    adsList.addAll([
      AdsModel(
        id: 1,
        title: "SPR Claw Hammers",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "Sp",
        typeService: "Rent",
        status: "accept",
      ),
      AdsModel(
        id: 2,
        title: "SPR Claw Hammers",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
      ),
      AdsModel(
        id: 2,
        title: "SPR Claw Hammers",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
      ),
      AdsModel(
        id: 2,
        title: "SPR Claw Hammers",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
      ),
      AdsModel(
        id: 2,
        title: "SPR Claw Hammers",
        place: "Riyadh – Malaz",
        dictation:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence,Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercial, and industrial clients. With years of experience, a skilled team of engineers and builders, and a strong commitment to safety and excellence",
        image: "assets/images/Rectangle 9772.png",
        images: [ImageApp.slidAds, ImageApp.slidAds, ImageApp.slidAds],
        favorite: false,
        price: 500,
        typeCoin: "\$",
        typeService: "Rent2",
        status: "accept",
      ),
    ]);
  }

  void favorite(int adsId) {
    final index = adsList.indexWhere((item) => item.id == adsId);
    if (index != -1) {
      adsList[index].favorite = !adsList[index].favorite;
      adsList.refresh();
    }
  }

  void getAdsDetails(int AdsId) {
    adsDetails.value = adsList.firstWhere((item) => item.id == AdsId);
  }
}
