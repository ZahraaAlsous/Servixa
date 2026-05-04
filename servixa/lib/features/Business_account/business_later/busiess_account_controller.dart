import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/user_type_model.dart';
import 'package:servixa/features/Business_account/data_layer/sourses/business_account_service.dart';

class BusiessAccountController extends GetxController {
  final BusinessAccountService businessAccountService =
      BusinessAccountService();
  RxList<File> listImage = <File>[].obs;
  RxList<File> listFile = <File>[].obs;
  RxList<CityModel> citiesList = <CityModel>[].obs;
  RxList<UserTypeModel> userTypesList = <UserTypeModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCities = false.obs;
  RxBool isLoadingUserTypes = false.obs;
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

  @override
  void onInit() {
    super.onInit();
    getCities((e) {
      AppSnackbar.showError(e);
    }); // getCategories();
    getUserTypes();
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc'],
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
      userTypesList.value = await businessAccountService.getUserTypes();
      log("==============================Controller : getUserTypes OK");
    } catch (e) {
      log("==============================Controller : getUserTypes ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );

      throw e;
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

      isLoading.value = true;
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
        documents: listFile,
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
      isLoading.value = false;
    }
  }

  void clearData() {
    businessNameArController.clear();
    businessNameEnController.clear();
    licenseNumberController.clear();
    activityController.clear();
    descriptionController.clear();
    addressDetailsController.clear();

    selectedUserTypeId.value = 0;
    selectedCityId.value = 0;
    selectedCity.value = null;
    selectedLatLng.value = null;
    currentAddress.value = "Select your location from map";
    listFile.clear();
    log(
      "==============================Controller : CreateBusinessAccount ClearFailed OK",
    );
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
