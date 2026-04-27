import 'dart:convert';
import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/auth/data_layer/sourses/auth_service.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';

class AuthController extends GetxController {
  final storage = FlutterSecureStorage();
  final AuthService authService = AuthService();
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  RxBool isPasswordVisible = true.obs;
  RxBool isAgreeTermsAndPolicies = false.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final Rx<Country?> selectedCountry = Rx<Country?>(Country.parse('SY'));

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void changePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void changeConfirmPasswordVisible() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void changeAgreeTermsAndPolicies() {
    isAgreeTermsAndPolicies.value = !isAgreeTermsAndPolicies.value;
  }

  Future<void> checkLoginStatus() async {
    String? token = await storage.read(key: "token");
    isLoggedIn.value = token != null;
    String? userJson = await storage.read(key: "user");
    if (userJson != null) {
      currentUser.value = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  void clearLoginFields() {
    emailLoginController.clear();
    passwordLoginController.clear();
    log("==============================Clear textFormFields Login");
  }

  void clearRegisterFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailRegisterController.clear();
    phoneController.clear();
    passwordRegisterController.clear();
    confirmPasswordController.clear();
    otpController.clear();
    log("==============================Clear textFormFields Register");
  }

  Future<void> refreshCurrentUser() async {
    try {
      String? userJson = await storage.read(key: "user");
      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        UserModel refreshedUser = UserModel.fromJson(userMap);
        currentUser.value = refreshedUser;
        log(
          "==============================Auth Controller: Current user refreshed",
        );
      }
    } catch (e) {
      log(
        "==============================Auth Controller: Error refreshing user: $e",
      );
    }
  }

  Future<void> register(
    // String first_name,
    // String last_name,
    // String email,
    // // String? email,
    // // String? phone,
    // String password,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isLoading.value = true;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Register IN");
      // await authService.register(
      //   firstNameController.text,
      //   lastNameController.text,
      //   emailRegisterController.text,
      //   passwordRegisterController.text
      // );
      String? finalEmail = emailRegisterController.text.trim().isEmpty
          ? null
          : emailRegisterController.text.trim();

      String? finalPhone;
      if (phoneController.text.trim().isNotEmpty) {
        String countryCode = selectedCountry.value?.phoneCode ?? "963";
        finalPhone = countryCode + phoneController.text.trim();
      }
      await authService.register(
        first_name: firstNameController.text,
        last_name: lastNameController.text,
        email: finalEmail,
        phone: finalPhone,
        password: passwordRegisterController.text,
      );
      onSuccess();
      log("==============================Controller : Register OK");
    } catch (e) {
      onError(e.toString());
      log("==============================Controller : Register ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isLoading.value = true;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Login IN");
      // UserModel user = await authService.login(
      //   emailController.text,
      //   passwordLoginController.text,
      // );
      await authService.login(
        emailLoginController.text,
        passwordLoginController.text,
      );
      String? userJson = await storage.read(key: "user");
      if (userJson != null) {
        currentUser.value = UserModel.fromJson(jsonDecode(userJson));
      }
      onSuccess();
      isLoggedIn.value = true;
      log("==============================Controller : Login OK");
      log(authService.storage.read(key: "token").toString());
    } catch (e) {
      onError(e.toString());
      log("==============================Controller : Login ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyEmail(
    // String code,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isLoading.value = true;
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Verify Email IN");
      bool isVerified = await authService.verifyEmail(otpController.text);
      if (isVerified) {
        String? userJson = await storage.read(key: "user");
        if (userJson != null) {
          currentUser.value = UserModel.fromJson(jsonDecode(userJson));
        }
        isLoggedIn.value = true;
        onSuccess();
        log("==============================Controller : Verify Email OK");
      } else {
        onError("Verification failed: Invalid code");
        log("==============================Controller : Verify Email FAILED");
      }
    } catch (e) {
      onError(e.toString());
      log("==============================Controller : Verify Email ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      log("==============================Controller : Logout IN");
      if (await authService.logout()) {
        isLoggedIn.value = false;
        await storage.delete(key: "token");
        await storage.delete(key: "user");
        currentUser.value = null;
        clearLoginFields();
        clearRegisterFields();
        log("==============================Controller : Logout OK");
        onSuccess();
      }
    } catch (e) {
      log("==============================Controller : Logout ERROR");
      log(
        "==============================Controller THE ERROR IS: " +
            e.toString(),
      );
      onError(e.toString());
    }
  }

  @override
  void onClose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
