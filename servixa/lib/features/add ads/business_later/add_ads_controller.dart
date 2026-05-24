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
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
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
  String? typeService;
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
  Map<String, dynamic> finalAnswers = {};
  var checkboxStates = <int, RxList<bool>>{}.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // getBusinessAccounts();
  //   businessAccountController.getBusinessAccountApproved();
  // }

  bool validateStepAddAds(int step) {
    switch (step) {
      case 0:
        // return selectedBusinessAccount.value != null
        return selectedBusinessAccountId.value != null
        // &&
        //     isBusinessAccountValid()
        ;
      case 1:
        // return selectedCategoryAds.value != null && selectedCategoryAdsId.value != null;
        return selectedCategoryAds.value != null ||
            selectedCategoryAdsId.value != null;
      case 2:
        // if (selectedCategoryAds.value?.subCategories!.isNotEmpty ?? false) {
        // if (selectedCategoryAds.value!.hasChildren) {
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
        type: typeService!,
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

  // bool validateImages() {
  //   if (selectedMainImage.value == null) {
  //     Get.snackbar("Alert", "Please select a main image");
  //     return false;
  //   }
  //   // if (imageSupList == null || imageSupList!.isEmpty) {
  //   //   Get.snackbar("Alert", "Please add at least one sub image");
  //   //   return false;
  //   // }
  //   return true;
  // }

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
    typeService = null;
    selectedLatLng.value = null;
    currentAddress.value = "Select your location from map";
    finalAnswers.clear();
    resetCheckboxes();
    addressDetailsController.clear();
    existingMainImageUrl.value = "";
    existingSubImagesUrls.clear();
    isEditOperation.value = false;
    adIdEdit.value = null;
    // checkboxStates.clear();
  }

  // ==================================
  // Rx<AdsModel?> adEdit = Rx<AdsModel?>(null);
  RxString existingMainImageUrl = "".obs;
  RxList<String> existingSubImagesUrls = <String>[].obs;
  RxBool isEditOperation = false.obs;
  Rx<int?> adIdEdit = Rx<int?>(null);
  int? oldCategoryId;
  int? oldSupCategoryId;

  void initialFailedEditAd(AdsModel ad) {
    // selectedBusinessAccount.value = ad.businessAccount!;
    isEditOperation.value = true;
    adIdEdit.value = ad.id;
    selectedBusinessAccountId.value = ad.businessAccountId!;
    oldCategoryId = ad.category!.parentId != null
        ? ad.category!.parentId
        : ad.category!.id;
    selectedCategoryAdsId.value = ad.category!.parentId != null
        ? ad.category!.parentId
        : ad.category!.id;

    selectedSubCategoryAds.value = ad.category!.parentId != null
        ? ad.category
        : null;
    selectedSubCategoryAdsId.value = ad.category!.parentId != null
        ? ad.category!.id
        : null;
    oldSupCategoryId = ad.category!.parentId != null ? ad.category!.id : null;
    titleController.text = ad.title;
    descriptionController.text = ad.dictation!;
    isRent.value = ad.isRent!;
    existingMainImageUrl.value = ad.image;
    existingSubImagesUrls.assignAll(
      ad.images.map((img) => img.toString()).toList(),
    );
    priceController.text = ad.price.toString();
    typeCoin = ad.typeCoin == "USD" ? "2" : "1";
    typeService = ad.typeService == "service" ? "1" : "2";

    addressDetailsController.text = ad.place ?? "";
    if (ad.lat != null && ad.lng != null) {
      final position = LatLng(ad.lat!, ad.lng!);
      selectedLatLng.value = position;

      _updateAddressFromLatLng(position);
    }
    _initializeDynamicQuestions(ad);
  }

  void _initializeDynamicQuestions(AdsModel ad) {
    try {
      if (ad.categoryQuestionAnswer == null ||
          ad.categoryQuestionAnswer!.isEmpty) {
        return;
      }

      finalAnswers.clear();
      checkboxStates.clear();

      for (var answer in ad.categoryQuestionAnswer!) {
        final questionId = answer.question.id;
        final question = categoryController.categoryQuestions.firstWhereOrNull(
          (q) => q.id == questionId,
        );

        if (question == null) {
          continue;
        }

        if (question.type == "checkbox") {
          try {
            List<String> selectedOptions = [];

            if (answer.value is String) {
              try {
                final decoded = jsonDecode(answer.value);
                if (decoded is List) {
                  selectedOptions = decoded.cast<String>();
                } else {
                  selectedOptions = [answer.value];
                }
              } catch (e) {
                selectedOptions = [answer.value];
              }
            } else if (answer.value is List) {
              selectedOptions = List<String>.from(answer.value);
            }

            initializeCheckboxes(questionId, question.metaData.options!.length);

            final states = checkboxStates[questionId];
            if (states != null) {
              for (int i = 0; i < question.metaData.options!.length; i++) {
                final option = question.metaData.options![i];
                states[i] = selectedOptions.contains(option);
              }
            }

            finalAnswers["custom_fields[$questionId]"] = jsonEncode(
              selectedOptions,
            );
          } catch (e) {
            log("Error parsing checkbox answer: $e");
          }
        } else if (question.type == "radio") {
          String selectedValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = selectedValue;
        } else if (question.type == "text") {
          String textValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = textValue;
        } else if (question.type == "number") {
          String numberValue = answer.value.toString();

          finalAnswers["custom_fields[$questionId]"] = numberValue;
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

  void removeExistingSubImageAt(int index) {
    if (index >= 0 && index < existingSubImagesUrls.length) {
      existingSubImagesUrls.removeAt(index);
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
        type: typeService!,
        other_images: listSelectedSubImage,
        dynamicQuestions: answersToSend.isEmpty ? null : answersToSend,
        lat: selectedLatLng.value!.latitude,
        lng: selectedLatLng.value!.longitude,
        price_currency: typeCoin!,
        address: addressDetailsController.text,
      );
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

  void prepareForNewCategory() {
    oldAnswers = Map.from(finalAnswers);

    finalAnswers.clear();

    checkboxStates.clear();
  }

  Map<String, dynamic> getFinalAnswersForSubmit() {
    final Map<String, dynamic> result = {};

    result.addAll(finalAnswers);

    for (var key in oldAnswers.keys) {
      result[key] = "";
    }

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

    if (indexPending != -1) {
      adsController.pendingMyAdList[indexPending] =
          adsController.adsDetails.value!;
    }
    if (indexAccept != -1) {
      adsController.acceptedMyAdList.removeWhere((item) => item.id == adId);
      adsController.adsList.removeWhere((item) => item.id == adId);

      adsController.pendingMyAdList.insert(0, adsController.adsDetails.value!);
    }

    if (indexReject != -1) {
      adsController.rejectedMyAdList.removeWhere((item) => item.id == adId);
      adsController.pendingMyAdList.insert(0, adsController.adsDetails.value!);
    }
    if (indexMyAd != -1) {
      adsController.pendingMyAdList[indexPending] =
          adsController.adsDetails.value!;
    }
    adsController.pendingMyAdList.refresh();
    adsController.acceptedMyAdList.refresh();
    adsController.adsList.refresh();
    adsController.rejectedMyAdList.refresh();
    adsController.myAdsList.refresh();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    addressDetailsController.dispose();

    super.onClose();
  }
}
