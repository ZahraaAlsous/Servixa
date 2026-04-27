import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';
import 'package:servixa/features/profile/data_layer/sourses/profile_service.dart';

enum AccountType { regular, business }

class ProfileController extends GetxController {
  final storage = FlutterSecureStorage();
  final AuthController authController = Get.put(AuthController());
  final profileService = ProfileService();
  RxBool isLoading = false.obs;
  UserModel? originalUser;

  var selectedAdType = AccountType.regular.obs;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    initialDataEditProfile();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   // ✅ هذا السطر هو السر: سيعيد البيانات للأصل في كل مرة تفتح الصفحة
  //   initialDataEditProfile();
  //   log(
  //     "=============================View Ready: Data Refreshed from Backend state",
  //   );
  // }

  void initialDataEditProfile() {
    final user = authController.currentUser.value;
    originalUser = user;

    firstNameController = TextEditingController(text: user?.firstName ?? '');
    lastNameController = TextEditingController(text: user?.lastName ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
  }

  void resetToOriginalData() {
    if (originalUser != null) {
      firstNameController.text = originalUser!.firstName ?? '';
      lastNameController.text = originalUser!.lastName ?? '';
      emailController.text = originalUser!.email ?? '';
      phoneController.text = originalUser!.phone ?? '';
      log("=============================Reset to original data");
    }
  }

  Future<void> updateProfile(
    void Function(bool isUpdated)? onSuccess,
    void Function(String error)? onError,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Update Profile IN");
      isLoading.value = true;

      Map<String, dynamic> updatedFields = {};
      final currentUser = authController.currentUser.value;
      if (firstNameController.text.isNotEmpty &&
          currentUser?.firstName != firstNameController.text) {
        updatedFields["first_name"] = firstNameController.text.trim();
      }

      if (lastNameController.text.isNotEmpty &&
          currentUser?.lastName != lastNameController.text) {
        updatedFields["last_name"] = lastNameController.text.trim();
      }

      if (emailController.text.isNotEmpty &&
          currentUser?.email != emailController.text) {
        updatedFields["email"] = emailController.text.trim();
      }

      if (phoneController.text.isNotEmpty &&
          currentUser?.phone != phoneController.text) {
        updatedFields["phone_number"] = phoneController.text.trim();
      }

      if (updatedFields.isEmpty) {
        log(
          "=============================Controller: Updater Profile No fields to update",
        );
        onSuccess?.call(false);
        return;
      }

      UserModel updatedUser = await profileService.updateProfile(updatedFields);

      authController.currentUser.value = updatedUser;
      await authController.refreshCurrentUser();

      log("=============================Controller: Updater Profile OK");

      onSuccess?.call(true);
    } catch (e) {
      log("=============================Controller: Updater Profile ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      onError?.call(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
