import 'dart:io';

import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';
import 'package:servixa/features/review/data_layer/models/review_model.dart';

class AdsController extends GetxController {
  RxBool showMore = false.obs;
  RxList<AdsModel> adsList = <AdsModel>[].obs;
  Rx<AdsModel?> adsDetails = Rx<AdsModel?>(null);

  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    getAds();
  }

  void getAds() {
    adsList.addAll([
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
        category: CategoryModel(
          id: 2,
          name: "Interior Design",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
            SubCategoryModel(
              id: 2,
              name: "Plumbing & Electrical",
              icon: "assets/images/Simplification.png",
            ),
          ],
        ),

        subCategory: SubCategoryModel(
          id: 2,
          name: "Plumbing & Electrical",
          icon: "assets/images/Simplification.png",
        ),
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
        category: CategoryModel(
          id: 1,
          name: "Equipment",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
          ],
          questions: [
            CategoryQuestionModel(
              id: 1,
              question: "question text",
              type: "text",
            ),
            CategoryQuestionModel(
              id: 2,
              question: "question dropdown",
              type: "dropdown",
              options: ["1", "2", "3"],
            ),
            CategoryQuestionModel(
              id: 3,
              question: "question checkbox",
              type: "checkbox",
            ),
          ],
        ),
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
        category: CategoryModel(
          id: 2,
          name: "Interior Design",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
            SubCategoryModel(
              id: 2,
              name: "Plumbing & Electrical",
              icon: "assets/images/Simplification.png",
            ),
          ],
        ),
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
        category: CategoryModel(
          id: 1,
          name: "Equipment",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
          ],
          questions: [
            CategoryQuestionModel(
              id: 1,
              question: "question text",
              type: "text",
            ),
            CategoryQuestionModel(
              id: 2,
              question: "question dropdown",
              type: "dropdown",
              options: ["1", "2", "3"],
            ),
            CategoryQuestionModel(
              id: 3,
              question: "question checkbox",
              type: "checkbox",
            ),
          ],
        ),
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
        category: CategoryModel(
          id: 2,
          name: "Interior Design",
          icon: "assets/images/Simplification.png",
          subCategories: [
            SubCategoryModel(
              id: 1,
              name: "Heavy Vehicles",
              icon: "assets/images/Simplification.png",
            ),
            SubCategoryModel(
              id: 2,
              name: "Plumbing & Electrical",
              icon: "assets/images/Simplification.png",
            ),
          ],
        ),
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
