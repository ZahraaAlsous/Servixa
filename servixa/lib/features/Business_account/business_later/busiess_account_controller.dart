import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/user_type_model.dart';
import 'package:servixa/features/Business_account/data_layer/sourses/business_account_service.dart';

class BusinessAccountController extends GetxController {
  final BusinessAccountService businessAccountService =
      BusinessAccountService();
  RxInt currentStep = 0.obs;
  RxList<File> listImage = <File>[].obs;
  RxList<File> listFile = <File>[].obs;
  RxList<CityModel> citiesList = <CityModel>[].obs;
  RxList<UserTypeModel> userTypesList = <UserTypeModel>[].obs;
  RxList<BusinessAccountModel> businessAccountsList =
      <BusinessAccountModel>[].obs;
  RxList<BusinessAccountModel> businessAccountsApprovedList =
      <BusinessAccountModel>[].obs;
  RxBool isLoadingCreateBusinessAccount = false.obs;
  RxBool isLoadingCities = false.obs;
  RxBool isLoadingUserTypes = false.obs;
  RxBool hasErrorLoadingUserTypes = false.obs;
  RxBool isLoadingBusinessAccounts = false.obs;
  RxBool hasErrorBusinessAccounts = false.obs;
  RxBool agreeLoadingCitiesAndUserTypes = false.obs;
  RxInt selectedUserTypeId = 0.obs;
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController businessNameArController = TextEditingController();
  TextEditingController businessNameEnController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressDetailsController = TextEditingController();
  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);
  RxInt selectedCityId = 0.obs;
  RxString currentAddress = "Select your location from map".obs;
  Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  // getCities((e) {
  //   AppSnackbar.showError(e);
  // }); // getCategories();
  //   // getUserTypes();
  // }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        listFile.addAll(files);
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  void deleteFile(int idFile) {
    listFile.removeAt(idFile);
  }

  void openFile(String filePath) async {
    try {
      final result = await OpenFilex.open(filePath);

      if (result.type != ResultType.done) {
        Get.snackbar(
          "Error",
          result.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('Error opening file: $e');
    }
  }

  Future<void> getUserTypes() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : getUserTypes IN");

      isLoadingUserTypes.value = true;
      hasErrorLoadingUserTypes.value = false;
      userTypesList.value = await businessAccountService.getUserTypes();
      log("==============================Controller : getUserTypes OK");
    } catch (e) {
      log("==============================Controller : getUserTypes ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      hasErrorLoadingUserTypes.value = true;
      // throw e;
    } finally {
      isLoadingUserTypes.value = false;
    }
  }

  Future<void> getCities(void Function(String e) onError) async {
    try {
      isLoadingCities.value = true;

      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : getCities IN");
      citiesList.value = await businessAccountService.getCities();
      log("==============================Controller : getCities OK");
    } catch (e) {
      log("==============================Controller : getCities ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      onError(e.toString());
      // throw e;
    } finally {
      isLoadingCities.value = false;
    }
  }

  void selectUserType(UserTypeModel userType) {
    selectedUserTypeId.value = userType.id;
    log(
      "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Controller: Selected User Type: ${userType.name} (ID: ${userType.id})",
    );
  }

  bool isSelected(UserTypeModel userType) {
    return selectedUserTypeId.value == userType.id;
  }

  void selectCity(CityModel? city) {
    if (city != null) {
      selectedCity.value = city;
      selectedCityId.value = city.id;
      log("Selected City: ${city.name} (ID: ${city.id})");
    } else {
      selectedCity.value = null;
      selectedCityId.value = 0;
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

  Future<void> createBusinessAccount(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : CreateBusinessAccount IN",
      );

      isLoadingCreateBusinessAccount.value = true;
      List<File> documents = [];
      documents.addAll(listFile);
      documents.addAll(listImage);

      await businessAccountService.createBusinessAccount(
        user_type_id: selectedUserTypeId.value,
        city_id: selectedCityId.value,
        business_nameAr: businessNameArController.text,
        business_nameEn: businessNameEnController.text,
        license_number: licenseNumberController.text,
        business_address: addressDetailsController.text,
        activities: activityController.text,
        details: descriptionController.text,
        lat: selectedLatLng.value!.latitude,
        lng: selectedLatLng.value!.longitude,
        documents: documents,
      );
      log(
        "==============================Controller : CreateBusinessAccount OK",
      );
      onSuccess();
      clearData();
    } catch (e) {
      log(
        "==============================Controller : CreateBusinessAccount ERROR",
      );
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );

      onError(e.toString());
    } finally {
      isLoadingCreateBusinessAccount.value = false;
    }
  }

  Future<void> clearFailedBusinessAccount() async {
    try {
      businessNameArController.clear();
      businessNameEnController.clear();
      licenseNumberController.clear();
      activityController.clear();
      descriptionController.clear();
      addressDetailsController.clear();

      currentStep = 0.obs;

      selectedUserTypeId.value = 0;
      selectedCityId.value = 0;
      selectedCity.value = null;
      selectedLatLng.value = null;
      currentAddress.value = "Select your location from map".tr();
    } catch (e) {
      log("Error in clearFailedBusinessAccount: $e");
    }
  }

  Future<void> clearData() async {
    try {
      await clearFailedBusinessAccount();
      listFile.clear();
      listImage.clear();
      // citiesList.clear();
      userTypesList.clear();
      for (var key in formKeys) {
        key.currentState?.reset();
      }

      log(
        "==============================Controller : CreateBusinessAccount ClearFailed OK",
      );
    } catch (e) {
      log("===============================Controller : ClearData ERROR: $e");
    }
  }

  final statusAccount = {'pending': 0, 'approved': 1, 'rejected': 2};
  void sortAccountByStatus(List<BusinessAccountModel> list) {
    list.sort((a, b) {
      int priorityA = statusAccount[a.status] ?? 99;
      int priorityB = statusAccount[b.status] ?? 99;
      return priorityA.compareTo(priorityB);
    });
  }

  Future<void> getBusinessAccount() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : GetBusinessAccount IN");

      isLoadingBusinessAccounts.value = true;
      hasErrorBusinessAccounts.value = false;
      businessAccountsList.value = await businessAccountService
          .getBusinessAccount();
      sortAccountByStatus(businessAccountsList);
    } catch (e) {
      log(
        "==============================Controller : GetBusinessAccount ERROR",
      );
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      hasErrorBusinessAccounts.value = true;
    } finally {
      isLoadingBusinessAccounts.value = false;
    }
  }

  Future<void> getBusinessAccountApproved() async {
    try {
      log(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : GetBusinessAccountApproved IN",
      );

      isLoadingBusinessAccounts.value = true;
      await getBusinessAccount();
      businessAccountsApprovedList.value = businessAccountsList
          .where((account) => account.status == "approved")
          .toList();
      log(
        "==============================Controller : GetBusinessAccountApproved OK",
      );
    } catch (e) {
      log(
        "==============================Controller : GetBusinessAccountApproved ERROR",
      );
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
    } finally {
      isLoadingBusinessAccounts.value = false;
    }
  }

  @override
  void onClose() {
    businessNameArController.dispose();
    businessNameEnController.dispose();
    licenseNumberController.dispose();
    activityController.dispose();
    descriptionController.dispose();
    addressDetailsController.dispose();
    super.onClose();
  }
}
