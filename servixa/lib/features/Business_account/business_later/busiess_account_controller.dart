import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' hide Trans;
import 'package:file_picker/file_picker.dart';
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
  RxBool isLoadingUserTypes = false.obs;

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
      isLoading.value = true;

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
      isLoading.value = false;
    }
  }
}
