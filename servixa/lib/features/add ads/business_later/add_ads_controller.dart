import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/add%20ads/data_layer/sourses/add_ad_service.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/data_layer/models/image_model.dart';
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
  final AdsController adsController = Get.put(AdsController());
  RxBool isCreate = false.obs;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  Rx<CategoryModel?> selectedCategoryAds = Rx<CategoryModel?>(null);
  Rx<int?> selectedCategoryAdsId = Rx<int?>(null);
  Rx<CategoryModel?> selectedSubCategoryAds = Rx<CategoryModel?>(null);
  Rx<int?> selectedSubCategoryAdsId = Rx<int?>(null);
  RxList<File> listSelectedMainImage = <File>[].obs;
  RxList<File> listSelectedSubImage = <File>[].obs;
  String? typeCoin;
  // String? typeService;
  Rx<String?> typeService = Rx<String?>(null);
  String? adTitle;
  // String? adSlug;
  String? adDescription;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressDetailsController = TextEditingController();
  // var selectedBusinessAccount = Rx<BusinessAccountModel?>(null);
  var selectedBusinessAccountId = Rx<int?>(null);
  // RxList<BusinessAccountModel> businessAccounts = <BusinessAccountModel>[].obs;
  RxList<BusinessAccountModel> businessAccountsApprovedList =
      <BusinessAccountModel>[].obs;
  RxList<File>? imageSupList = <File>[].obs;
  RxBool isRent = false.obs;
  RxString currentAddress = "Select your location from map".obs;
  Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);
  Rx<File?> selectedMainImage = Rx<File?>(null);
  RxMap<String, dynamic> finalAnswers = <String, dynamic>{}
      .obs; 
  RxMap<int, String> radioAnswer = <int, String>{}.obs;
  RxMap<int, List<String>> checkBoxAnswer = <int, List<String>>{}.obs;


  bool validateStepAddAds(int step) {
    switch (step) {
      case 0:
        return selectedBusinessAccountId.value != null;
      case 1:
        return selectedCategoryAds.value != null ||
            selectedCategoryAdsId.value != null;
      case 2:
        final bool hasCategory = selectedCategoryAds.value != null;
        final bool hasChildren =
            hasCategory && selectedCategoryAds.value!.hasChildren;
        final bool hasSubCategory = selectedSubCategoryAds.value != null;
        final bool hasSubCategoryParent =
            hasSubCategory && selectedSubCategoryAds.value!.parentId != null;
        if (hasChildren || hasSubCategoryParent) {
          return selectedSubCategoryAds.value != null &&
              selectedSubCategoryAdsId.value != null;
        }
        return true;
      case 3:
        return adTitle != null &&
            adTitle!.isNotEmpty &&
            adDescription != null &&
            adDescription!.isNotEmpty &&
            typeCoin != null &&
            typeService != null &&
            selectedMainImage.value != null &&
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

  void saveRadioAnswer(int questionId, String value) {
    radioAnswer[questionId] = value;
    finalAnswers["custom_fields[$questionId]"] = value;
    log("Saved radio answer for question $questionId: $value");
  }

  void saveCheckBoxAnswer(int questionId, List<String> value) {
    checkBoxAnswer[questionId] = value;
    final String jsonValue = jsonEncode(value);
    finalAnswers["custom_fields[$questionId]"] = jsonValue;
    log("Saved checkbox answer for question $questionId: $value");
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
      AdsModel? ad = await addAdService.createAd(
        // business_account_id: selectedBusinessAccount.value!.id,
        business_account_id: selectedBusinessAccountId.value!,
        name: titleController.text,
        description: descriptionController.text,
        price: priceController.text,
        is_rent: isRent.value ? 1 : 0,
        category_id: selectedSubCategoryAds.value != null
            // ? selectedSubCategoryAds.value!.id
            ? selectedSubCategoryAdsId.value!
            // : selectedCategoryAds.value!.id,
            : selectedCategoryAdsId.value!,
        main_image: selectedMainImage.value!,
        type: typeService.value!,
        other_images: listSelectedSubImage,
        dynamicQuestions: finalAnswers,
        lat: selectedLatLng.value!.latitude,
        lng: selectedLatLng.value!.longitude,
        price_currency: typeCoin!,
        address: addressDetailsController.text,
      );
      //       if (isCreateSuccess) {
      //               onSuccess();
      // adsController.pendingMyAdList.add(element)
      //       }
      if (ad != null) {
        onSuccess();
        adsController.pendingMyAdList.insert(0, ad);
      }
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
          final answer = finalAnswers["custom_fields[${question.id}]"];

          if (answer == null || (answer is List && answer.isEmpty)) {
            Get.snackbar(
              "Alert",
              "${question.question} is required",
              backgroundColor: ThemeApp.Foundation_Main_main_50,
              colorText: ThemeApp.Foundation_Main_main_500,
            );
            return false;
          }
        } else {
          final answer = finalAnswers["custom_fields[${question.id}]"];

          if (answer == null || answer.toString().isEmpty) {
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

  bool isAgree() {
    if (authController.isAgreeTermsAndPolicies.value) {
      return false;
    }
    return true;
  }

  void cleanCleanAd() {
    // selectedBusinessAccount.value = null;
    selectedBusinessAccountId.value = null;
    selectedCategoryAds.value = null;
    selectedCategoryAdsId.value = null;
    selectedSubCategoryAds.value = null;
    selectedSubCategoryAdsId.value = null;
    titleController.clear();
    descriptionController.clear();
    isRent.value = false;
    priceController.clear();
    typeCoin = null;
    selectedMainImage.value = null;
    listSelectedSubImage.clear();
    listSelectedMainImage.clear();
    typeCoin = null;
    typeService.value = null;
    selectedLatLng.value = null;
    currentAddress.value = "Select your location from map".tr();
    finalAnswers.clear();
    // resetCheckboxes();
    addressDetailsController.clear();
    existingMainImageUrl.value = "";
    // existingSubImagesUrls.clear();
    existingSubImages.clear();
    isEditOperation.value = false;
    adIdEdit.value = null;
    oldAnswers.clear();
    radioAnswer.clear();
    checkBoxAnswer.clear();
    // checkboxStates.clear();
  }

  // ==================================
  // Rx<AdsModel?> adEdit = Rx<AdsModel?>(null);
  RxString existingMainImageUrl = "".obs;
  // RxList<String> existingSubImagesUrls = <String>[].obs;
  RxList<ImageModel> existingSubImages = <ImageModel>[].obs;
  RxBool isEditOperation = false.obs;
  Rx<int?> adIdEdit = Rx<int?>(null);
  int? oldCategoryId;
  int? oldSupCategoryId;
  Rx<BusinessAccountModel?> businessAccountAdUpdate = Rx<BusinessAccountModel?>(
    null,
  );

  // zoz
  Future<void> initialFailedEditAd(AdsModel ad) async {
    // selectedBusinessAccount.value = ad.businessAccount!;
    isEditOperation.value = true;
    adIdEdit.value = ad.id;
    selectedBusinessAccountId.value = ad.businessAccountId!;
    // oldCategoryId = ad.category!.parentId != null
    //     ? ad.category!.parentId
    //     : ad.category!.id;
    // selectedCategoryAdsId.value = ad.category!.parentId != null
    //     ? ad.category!.parentId
    //     : ad.category!.id;

    // selectedSubCategoryAds.value = ad.category!.parentId != null
    //     ? ad.category
    //     : null;
    // selectedSubCategoryAdsId.value = ad.category!.parentId != null
    //     ? ad.category!.id
    //     : null;
    // oldSupCategoryId = ad.category!.parentId != null ? ad.category!.id : null;

    if (ad.category != null) {
      oldCategoryId = ad.category!.parentId != null
          ? ad.category!.parentId
          : ad.category!.id;
      selectedCategoryAdsId.value = ad.category!.parentId != null
          ? ad.category!.parentId
          : ad.category!.id;

      if (ad.category!.parentId != null) {
        selectedSubCategoryAds.value = ad.category;
        selectedSubCategoryAdsId.value = ad.category!.id;
        oldSupCategoryId = ad.category!.id;
      } else {
        selectedSubCategoryAds.value = null;
        selectedSubCategoryAdsId.value = null;
        oldSupCategoryId = null;
      }
    } else {
      log(" ad.category is null, using stored or inferred values");

      if (selectedCategoryAdsId.value != null) {
        oldCategoryId = selectedCategoryAdsId.value;
        log(
          " Using stored selectedCategoryAdsId: ${selectedCategoryAdsId.value}",
        );
      } else if (ad.category_id != null) {
        oldCategoryId = ad.category_id;
        selectedCategoryAdsId.value = ad.category_id;
        log("Using ad.categoryId: ${ad.category_id}");
      } else {
        log("Cannot determine category for ad ${ad.id}");
        Get.snackbar("Error", "Cannot load category data");
        return;
      }

      if (selectedSubCategoryAdsId.value != null) {
        oldSupCategoryId = selectedSubCategoryAdsId.value;
        log(
          "Keeping stored selectedSubCategoryAdsId: ${selectedSubCategoryAdsId.value}",
        );
      }
    }
    titleController.text = ad.title;
    descriptionController.text = ad.dictation!;
    isRent.value = ad.isRent!;
    existingMainImageUrl.value = ad.image;
    // existingSubImagesUrls.assignAll(
    //   ad.images.map((img) => img.toString()).toList(),
    // );
    existingSubImages.assignAll(ad.images);
    priceController.text = ad.price.toString();
    typeCoin = ad.typeCoin == "USD" ? "2" : "1";
    typeService.value = ad.typeService == "service" ? "1" : "2";
    businessAccountAdUpdate.value = ad.businessAccount;
    addressDetailsController.text = ad.place ?? "";
    if (ad.lat != null && ad.lng != null) {
      final position = LatLng(ad.lat!, ad.lng!);
      selectedLatLng.value = position;

      _updateAddressFromLatLng(position);
    }

    if (selectedSubCategoryAdsId.value != null) {
      await categoryController.getCategoryQuestions(
        selectedCategoryAdsId.value!,
        false,
      );
      await categoryController.getCategoryQuestions(
        selectedSubCategoryAdsId.value!,
        true,
      );
    } else if (selectedCategoryAdsId.value != null) {
      await categoryController.getCategoryQuestions(
        selectedCategoryAdsId.value!,
        false,
      );
    }
    await _initializeDynamicQuestions(ad);
    log("*************************************initialize ad done");
  }

  // zoz
  Future<dynamic> _initializeDynamicQuestions(AdsModel ad) async {
    try {
      if (ad.categoryQuestionAnswer == null ||
          ad.categoryQuestionAnswer!.isEmpty) {
        log("####################################Null");
        return;
      }
      log("####################################NotNull");

      finalAnswers.clear();

      for (var answer in ad.categoryQuestionAnswer!) {
        final questionId = answer.question.id;
        final question = categoryController.categoryQuestions.firstWhereOrNull(
          (q) => q.id == questionId,
        );

        if (question == null) {
          log("###########################qustion null");
          continue;
        }
        if (question.type == "checkbox") {
          if (answer.value == null ||
              answer.value.toString().trim().isEmpty ||
              answer.value.toString() == "null") {
            finalAnswers["custom_fields[$questionId]"] = "";
            checkBoxAnswer[questionId] = <String>[].obs;
            log("@@@@@@@@@@@@@@@@@@@@@@@@@Empty");
          } else {
            String rawValue = answer.value.toString();
            log(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ rawValue $rawValue",
            );

            String cleanedValue = rawValue
                .replaceAll('[', '')
                .replaceAll(']', '')
                .trim();
            log(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ cleanedValue $cleanedValue",
            );
            List<String> parsedOptions = cleanedValue.isEmpty
                ? []
                : cleanedValue.split(',').map((e) => e.trim()).toList();
            finalAnswers["custom_fields[$questionId]"] = jsonEncode(
              parsedOptions,
            );

            log(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ parsedOptions $parsedOptions",
            );

            checkBoxAnswer[questionId] = parsedOptions.obs;
            log(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ checkBoxAnswer ${checkBoxAnswer[questionId]}",
            );
          }
        } else if (question.type == "radio") {
          String selectedValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = selectedValue;
          radioAnswer[questionId] = selectedValue;
        } else if (question.type == "text") {
          String textValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = textValue;
        } else if (question.type == "number") {
          String numberValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = numberValue;
        } else if (question.type == "select") {
          String selectValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = selectValue;
        } else if (question.type == "textarea") {
          String selectValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = selectValue;
        }
      }
    } catch (e) {
      log(" Error initializing dynamic questions: $e");
    }
  }

  Future<void> _updateAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placee = placemarks[0];
        currentAddress.value = "${placee.street}, ${placee.locality}";
        // addressDetailsController.text = placee.street ?? '';
      }
    } catch (e) {
      currentAddress.value = "Unknown Location";
    }
  }

  Future<void> updateAd(
    int adId,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : updateAd IN");
      isCreate.value = true;
      final answersToSend = getFinalAnswersForSubmit();
      log("+++++++++++++++++++++++++++++++++ $answersToSend");
      adsController.adsDetails.value = await addAdService.updateAd(
        // business_account_id: selectedBusinessAccount.value!.id,
        adId: adId,
        name: titleController.text,
        description: descriptionController.text,
        price: priceController.text,
        is_rent: isRent.value ? 1 : 0,
        category_id: selectedSubCategoryAds.value != null
            // ? selectedSubCategoryAds.value!.id
            ? selectedSubCategoryAdsId.value!
            // : selectedCategoryAds.value!.id,
            : selectedCategoryAdsId.value!,
        main_image: selectedMainImage.value,
        type: typeService.value!,
        other_images: listSelectedSubImage,
        // dynamicQuestions: answersToSend.isEmpty ? null : answersToSend,
        dynamicQuestions: answersToSend,
        lat: selectedLatLng.value!.latitude,
        lng: selectedLatLng.value!.longitude,
        price_currency: typeCoin!,
        address: addressDetailsController.text,
      );
      log(
        "////////////////////selectedSubCategoryAds.value ${selectedSubCategoryAds.value}",
      );
      log(
        "////////////////////selectedCategoryAds.value ${selectedCategoryAds.value}",
      );
      adsController.adsDetails.value!.category =
          selectedSubCategoryAds.value ?? selectedCategoryAds.value;
      adsController.adsDetails.value!.businessAccount =
          businessAccountAdUpdate.value;
      adsController.adsDetails.refresh();
      reFreshListAfterUpdateAd(adId);
      onSuccess();
    } catch (e) {
      // log(e.toString());
      onError(e.toString());
      log("==============================Controller: UpdateAd ERROR");
      log("==============================The error is: $e");
    } finally {
      isCreate.value = false;
    }
  }

  Map<String, dynamic> oldAnswers = {};

  // zoz
  void prepareForNewCategory() {
    log(" Preparing for new category - Saving old answers");
    log(" Old finalAnswers before save: ${finalAnswers.keys}");

    if (finalAnswers.isNotEmpty) {
      oldAnswers = Map.from(finalAnswers);
      log(" Old answers saved: ${oldAnswers.keys}");
    } else {
      log(" No old answers to save");
      oldAnswers.clear();
    }

    finalAnswers.clear();

    // checkboxStates.clear();
    log("888888888888888888888" + radioAnswer.toString());

    log(" Prepared for new category. Old answers count: ${oldAnswers.length}");
  }

  // zoz
  Map<String, dynamic> getFinalAnswersForSubmit() {
    final Map<String, dynamic> result = {};

    if (finalAnswers.isNotEmpty) {
      result.addAll(finalAnswers);
      log("New answers to save: ${finalAnswers.keys}");
    }

    if (oldAnswers.isNotEmpty) {
      for (var key in oldAnswers.keys) {
        result[key] = "";
        log("Marking old answer for deletion: $key");
      }
    }

    log("Final answers to submit: ${result.keys}");
    return result;
  }

  void reFreshListAfterUpdateAd(int adId) {
    final indexPending = adsController.pendingMyAdList.indexWhere(
      (item) => item.id == adId,
    );
    final indexAccept = adsController.acceptedMyAdList.indexWhere(
      (item) => item.id == adId,
    );
    final indexReject = adsController.rejectedMyAdList.indexWhere(
      (item) => item.id == adId,
    );
    final indexMyAd = adsController.myAdsList.indexWhere(
      (item) => item.id == adId,
    );
    final indexGeneralAds = adsController.adsList.indexWhere(
      (item) => item.id == adId,
    );

    if (indexPending != -1) {
      adsController.pendingMyAdList[indexPending] =
          adsController.adsDetails.value!;
    }

    if (indexAccept != -1) {
      adsController.acceptedMyAdList[indexAccept] =
          adsController.adsDetails.value!;
    }

    if (indexReject != -1) {
      adsController.rejectedMyAdList[indexReject] =
          adsController.adsDetails.value!;
    }

    if (indexMyAd != -1) {
      adsController.myAdsList[indexMyAd] = adsController.adsDetails.value!;
    }

    if (indexGeneralAds != -1) {
      adsController.adsList[indexGeneralAds] = adsController.adsDetails.value!;
    }

    adsController.pendingMyAdList.refresh();
    adsController.acceptedMyAdList.refresh();
    adsController.adsList.refresh();
    adsController.rejectedMyAdList.refresh();
    adsController.myAdsList.refresh();
  }

  // ==================================================
  RxMap<int, bool> isDeleteImageNaw = <int, bool>{}.obs;

  Future<void> deleteImage({
    required int adId,
    required int imageId,
    required int localIndex,
    // bool isNetworkImage = true,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : delete image IN");
      isDeleteImageNaw[imageId] = true;
      bool isDeleted = await addAdService.deleteImage(
        adId: adId,
        imageId: imageId,
      );

      if (isDeleted) {
        log("================= Controller: delete image OK");
        existingSubImages.removeAt(localIndex);
        if (adsController.adsDetails.value != null) {
          adsController.adsDetails.value!.images.removeAt(localIndex);
          adsController.adsDetails.refresh();
        }
        log("Existing sub image removed from local list");
        existingSubImages.refresh();
        listSelectedSubImage.refresh();
      }
    } catch (e) {
      log("======================controller: Delete image ERROR");
      log("======================The error is : $e");
    } finally {
      isDeleteImageNaw[imageId] = false;
    }
  }

  @override
  void onClose() {
    // titleController.dispose();
    // descriptionController.dispose();
    // priceController.dispose();
    // addressDetailsController.dispose();

    super.onClose();
  }
}
