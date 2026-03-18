import 'package:get/get.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';

class SearchFilterController extends GetxController {
  AdsController adsController = Get.put(AdsController());
  RxList<AdsModel> adsSearchList = <AdsModel>[].obs;
  RxString filterSearch = "".obs;

  @override
  void onInit() {
    super.onInit();
    getPopularAds();
  }

  void getPopularAds() {
    adsSearchList.addAll([
      AdsModel(
        id: 1,
        title: "SPR Claw Hammers1",
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
        listReview: [
          ReviewModel(
            id: 1,
            text: "very beatufull",
            user: UserModel(id: 1, firstName: "Zahraa", lastName: "Alsous"),
            date: "6/15/2026",
          ),
        ],
      ),
      AdsModel(
        id: 2,
        title: "SPR Claw Hammers2",
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
        id: 3,
        title: "SPR Claw Hammers3",
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
        id: 4,
        title: "SPR Claw Hammers4",
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
        id: 5,
        title: "SPR Claw Hammers5",
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

  void applyFilters() {
    searchResault(name: filterSearch.value.isEmpty ? null : filterSearch.value);
  }

  void searchResault({String? name}) {
    adsSearchList.value = adsController.adsList
        .where((item) => item.title == name)
        .toList();
  }
}
