import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/add%20ads/data_layer/sourses/add_ad_service.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';

class AddAdsController extends GetxController {
  AuthController authController = Get.put(AuthController());
  BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  final AddAdService addAdService = AddAdService();
  CategoryController categoryController = Get.put(CategoryController());
  RxBool isCreate = false.obs;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  Rx<CategoryModel?> selectedCategoryAds = Rx<CategoryModel?>(null);
  Rx<CategoryModel?> selectedSubCategoryAds = Rx<CategoryModel?>(null);
  RxList<File> listSelectedMainImage = <File>[].obs;
  RxList<File> listSelectedSubImage = <File>[].obs;
  String? typeCoin;
  String? typeService;
  String? adTitle;
  // String? adSlug;
  String? adDescription;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressDetailsController = TextEditingController();
  var selectedBusinessAccount = Rx<BusinessAccountModel?>(null);
  // RxList<BusinessAccountModel> businessAccounts = <BusinessAccountModel>[].obs;
  RxList<BusinessAccountModel> businessAccountsApprovedList =
      <BusinessAccountModel>[].obs;
  RxList<File>? imageSupList = <File>[].obs;
  RxBool isRent = false.obs;
  RxString currentAddress = "Select your location from map".obs;
  Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);
  Rx<File?> selectedMainImage = Rx<File?>(null);
    Map<String, dynamic> finalAnswers = {};
  var checkboxStates = <int, RxList<bool>>{}.obs;


  @override
  void onInit() {
    super.onInit();
    // getBusinessAccounts();
    businessAccountController.getBusinessAccountApproved();
  }

  bool validateStepAddAds(int step) {
    switch (step) {
      case 0:
        return selectedBusinessAccount.value != null
        // &&
        //     isBusinessAccountValid()
        ;
      case 1:
        return selectedCategoryAds.value != null;
      case 2:
        // if (selectedCategoryAds.value?.subCategories!.isNotEmpty ?? false) {
        if (selectedCategoryAds.value!.hasChildren) {
          return selectedSubCategoryAds.value != null;
        }
        return true;
      case 3:
        return adTitle != null &&
            adTitle!.isNotEmpty &&
            adDescription != null &&
            adDescription!.isNotEmpty &&
            typeCoin != null &&
            typeService != null &&
            listSelectedMainImage.isNotEmpty &&
            listSelectedSubImage.isNotEmpty &&
            authController.isAgreeTermsAndPolicies.value;

      default:
        return false;
    }
  }

  void addImage(RxList<File> list, File image) {
    list.add(image);
  }

  void removeImageAt(RxList<File> list, int index) {
    list.removeAt(index);
  }

  bool isSelected(CategoryModel category, int selectedCategoryId) {
    return selectedCategoryId == category.id;
  }


  void saveSimpleAnswer(int questionId, String value) {
    finalAnswers["custom_fields[$questionId]"] = value;
    log(finalAnswers.toString());
  }

  void initializeCheckboxes(int questionId, int optionsCount) {
    if (!checkboxStates.containsKey(questionId)) {
      checkboxStates[questionId] = List.generate(
        optionsCount,
        (_) => false,
      ).obs;
    }
    log(checkboxStates.toString());
  }

  void collectCheckboxAnswers() {
    for (var question in categoryController.categoryQuestions) {
      if (question.type == "checkbox") {
        List<String> selectedForThisQuestion = [];

        var states = checkboxStates[question.id];
        for (int i = 0; i < states!.length; i++) {
          if (states[i] == true) {
            selectedForThisQuestion.add(question.metaData.options![i]);
          }
        }

        String finalKey = "custom_fields[${question.id}]";
        String finalValue = jsonEncode(selectedForThisQuestion);
        saveSimpleAnswer(question.id, finalValue);
        log("$finalKey : $finalValue");
        log(checkboxStates.toString());
        log("===========================Final answers: $finalAnswers");
      }
    }
  }

  Future<void> updatePosition(LatLng position) async {
    selectedLatLng.value = position;
    log(selectedLatLng.toString());
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        currentAddress.value = "${place.street}, ${place.locality}";
      }
    } catch (e) {
      currentAddress.value = "Unknown Location";
    }
  }

  Future<void> createAd(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log(">>>>>>>>>>..>>>>>>>>>>>>>>>>>>");
      isCreate.value = true;
      await addAdService.createAd(
        business_account_id: selectedBusinessAccount.value!.id,
        name: titleController.text,
        description: descriptionController.text,
        price: priceController.text,
        is_rent: isRent.value ? 1 : 0,
        category_id: selectedSubCategoryAds.value != null
            ? selectedSubCategoryAds.value!.id
            : selectedCategoryAds.value!.id,
        main_image: selectedMainImage.value!,
        type: typeService!,
        other_images: listSelectedSubImage,
        dynamicQuestions: finalAnswers,
        lat: selectedLatLng.value!.latitude,
        lng: selectedLatLng.value!.longitude,
        price_currency: typeCoin!,
        address: addressDetailsController.text,
      );
      onSuccess();
    } catch (e) {
      log(e.toString());
      onError(e.toString());
    } finally {
      isCreate.value = false;
    }
  }

  void removeMainImage() {
    selectedMainImage.value = null;
  }

  bool validateDynamicQuestions() {
    for (var question in categoryController.categoryQuestions) {
      if (question.metaData.is_required) {
        if (question.type == "checkbox") {
          var states = checkboxStates[question.id];
          bool hasSelection = false;
          if (states != null) {
            for (int i = 0; i < states.length; i++) {
              if (states[i] == true) {
                hasSelection = true;
                break;
              }
            }
          }
          if (!hasSelection) {
            Get.snackbar(
              "Alert",
              "${question.question} is required",
              backgroundColor: ThemeApp.Foundation_Main_main_50,
              colorText: ThemeApp.Foundation_Main_main_500,
            );
            return false;
          }
        } else {
          String? answer = finalAnswers["custom_fields[${question.id}]"];
          if (answer == null || answer.isEmpty) {
            Get.snackbar(
              "Alert",
              "${question.question} is required",
              backgroundColor: ThemeApp.Foundation_Main_main_50,
              colorText: ThemeApp.Foundation_Main_main_500,
            );
            return false;
          }
        }
      }
    }
    return true;
  }

  // ✅ التحقق من الصور قبل الإرسال النهائي
  bool validateImages() {
    if (selectedMainImage.value == null) {
      Get.snackbar("Alert", "Please select a main image");
      return false;
    }
    // if (imageSupList == null || imageSupList!.isEmpty) {
    //   Get.snackbar("Alert", "Please add at least one sub image");
    //   return false;
    // }
    return true;
  }

  bool isAgree() {
    if (authController.isAgreeTermsAndPolicies.value) {
      return false;
    }
    return true;
  }

  void resetCheckboxes() {
    for (var entry in checkboxStates.entries) {
      for (int i = 0; i < entry.value.length; i++) {
        entry.value[i] = false;
      }
    }
    log("🔄 Checkboxes reset (all set to false)");
  }

  void cleanCleanAd() {
    selectedBusinessAccount.value = null;
    selectedCategoryAds.value = null;
    selectedSubCategoryAds.value = null;
    titleController.clear();
    descriptionController.clear();
    isRent.value = false;
    priceController.clear();
    typeCoin = null;
    selectedMainImage.value = null;
    listSelectedSubImage.clear();
    listSelectedMainImage.clear();
    typeCoin = null;
    typeService = null;
    selectedLatLng.value = null;
    currentAddress.value = "Select your location from map";
    finalAnswers.clear();
    resetCheckboxes();
    // checkboxStates.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    super.onClose();
  }
}
