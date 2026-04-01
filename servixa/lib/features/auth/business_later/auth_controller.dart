import 'package:get/get.dart' hide Trans;

class AuthController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isAgreeTermsAndPolicies = false.obs;

  void changePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void changeConfirmPasswordVisible() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void changeAgreeTermsAndPolicies() {
    isAgreeTermsAndPolicies.value = !isAgreeTermsAndPolicies.value;
  }
}
