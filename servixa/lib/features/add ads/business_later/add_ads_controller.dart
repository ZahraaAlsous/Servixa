import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/sub_category_model.dart';

class AddAdsController extends GetxController {
  AuthController authController = Get.put(AuthController());
  Rx<CategoryModel?> selectedCategoryAds = Rx<CategoryModel?>(null);
  Rx<SubCategoryModel?> selectedSubCategoryAds = Rx<SubCategoryModel?>(null);
  RxList<File> listSelectedMainImage = <File>[].obs;
  RxList<File> listSelectedSubImage = <File>[].obs;
  // var selectedCurrency = Rx<String?>(null);
  String? typeCoin;
  String? typeService;
  String? adTitle;
  String? adSlug;
  String? adDescription;
  var selectedBusinessAccount = Rx<BusinessAccountModel?>(null);
  RxList<BusinessAccountModel> businessAccounts = <BusinessAccountModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBusinessAccounts();
  }

  bool validateStepAddAds(int step) {
    switch (step) {
      case 0:
        return selectedBusinessAccount.value != null &&
            isBusinessAccountValid();
      case 1:
        return selectedCategoryAds.value != null;
      case 2:
        if (selectedCategoryAds.value?.subCategories.isNotEmpty ?? false) {
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
    list.add(image); // ✅ هذه الطريقة تعمل مع .obs
  }

  // ✅ دالة لحذف صورة
  void removeImageAt(RxList<File> list, int index) {
    list.removeAt(index);
  }

  Future<void> pickImage(RxList<File> list) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024, // ✅ أضفها عشان تتحكم بحجم الصورة
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        addImage(list, File(pickedFile.path));
        log('Image selected: ${pickedFile.path}');
      } else {
        log('User cancelled');
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  var isLoading = false.obs;

  Future<void> fetchBusinessAccounts() async {
    isLoading.value = true;
    try {
      businessAccounts.value = [
        BusinessAccountModel(
          id: 1,
          businessNameArabic: "businessNameArabic",
          businessNameEnglish: "businessNameEnglish",
          typeBusinessAccount: "typeBusinessAccount",
          licenseNumber: 12233,
          city: "city",
          addressDetail: "addressDetail",
          location: "location",
          activities: "activities",
          details: "details",
          doc: [""],
          status: "Accepted",
        ),
        BusinessAccountModel(
          id: 2,
          businessNameArabic: "businessNameArabic",
          businessNameEnglish: "businessNameEnglish",
          typeBusinessAccount: "typeBusinessAccount",
          licenseNumber: 12233,
          city: "city",
          addressDetail: "addressDetail",
          location: "location",
          activities: "activities",
          details: "details",
          doc: [""],
          status: "Rejected",
        ),
      ];
    } catch (e) {
      log('خطأ في جلب الحسابات: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool isBusinessAccountValid() {
    if (selectedBusinessAccount.value == null) return false;
    return selectedBusinessAccount.value?.status == "Accepted";
  }
}
