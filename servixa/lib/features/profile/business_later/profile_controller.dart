import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/profile/data_layer/sourses/profile_service.dart';

enum AccountType { regular, business }

class ProfileController extends GetxController {
  final profileService = ProfileService();
  RxBool isLoading = false.obs;
  final AuthController authController = Get.put(AuthController());
  var selectedAdType = AccountType.regular.obs;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    initialDataEditProfile();
    super.onInit();
  }

  void initialDataEditProfile() {
    final user = authController.currentUser.value;
    firstNameController = TextEditingController(text: user?.firstName ?? '');
    lastNameController = TextEditingController(text: user?.lastName ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
  }

  Future<void> updateProfile(
    // {
    // String? first_name,
    // String? last_name,
    // String? email,
    // String? phone,
    // image
    void Function(bool isUpdated)? onSuccess,
    void Function(String error)? onError,
    // }
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Update Profile IN");
      isLoading.value = true;
      Map<String, dynamic> updatedFields = {};
      final currentUser = authController.currentUser.value;
      if (firstNameController.text.isNotEmpty &&
          currentUser?.firstName != firstNameController.text)
        updatedFields["first_name"] = firstNameController.text;
      if (lastNameController.text.isNotEmpty &&
          currentUser?.lastName != lastNameController.text)
        updatedFields["last_name"] = lastNameController.text;
      if (emailController.text.isNotEmpty &&
          currentUser?.email != emailController.text)
        updatedFields["email"] = emailController.text;
      if (phoneController.text.isNotEmpty &&
          currentUser?.phone != phoneController.text)
        updatedFields["phone_number"] = phoneController.text;

      if (updatedFields.isEmpty) {
        onSuccess?.call(false);
        return;
      }
      await profileService.updateProfile(updatedFields);
      log("==============================Controller : Update Profile OK");
      onSuccess?.call(true);
    } catch (e) {
      log("==============================Controller : Update Profile ERROR");
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
