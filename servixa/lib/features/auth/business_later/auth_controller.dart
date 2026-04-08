import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/auth/data_layer/sourses/auth_service.dart';

class AuthController extends GetxController {
  final storage = FlutterSecureStorage();
  // final AuthService authService = AuthService();
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isAgreeTermsAndPolicies = false.obs;

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

  // Future<void> register(
  //   String first_name,
  //   String last_name,
  //   String email,
  //   // String? email,
  //   // String? phone,
  //   String password,
  //   void Function() onSuccess,
  //   void Function(String e) onError,
  // ) async {
  //   try {
  //     isLoading.value = true;
  //     log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Controller : Register IN");
  //     await authService.register(first_name, last_name, email, password);
  //     // await authService.register(first_name, last_name, email, phone, password);
  //     onSuccess();
  //     log("==============================Controller : Register OK");
  //   } catch (e) {
  //     onError(e.toString());
  //     log("==============================Controller : Register ERROR");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
