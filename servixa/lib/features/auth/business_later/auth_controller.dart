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

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isAgreeTermsAndPolicies = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final Rx<Country?> selectedCountry = Rx<Country?>(
    Country.parse('SY'),
  ); // edit

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
      await authService.register(
        firstNameController.text,
        lastNameController.text,
        emailPhoneController.text,
        passwordRegisterController.text,
      );
      // await authService.register(first_name, last_name, email, password);
      // await authService.register(first_name, last_name, email, phone, password);
      onSuccess();
      log("==============================Controller : Register OK");
    } catch (e) {
      onError(e.toString());
      log("==============================Controller : Register ERROR");
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
      UserModel user = await authService.login(
        emailController.text,
        passwordLoginController.text,
      );
      currentUser.value = user;
      onSuccess();
      isLoggedIn.value = true;
      log("==============================Controller : Login OK");
      log(authService.storage.read(key: "token").toString());
    } catch (e) {
      onError(e.toString());
      log("==============================Controller : Login ERROR");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordLoginController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailPhoneController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
