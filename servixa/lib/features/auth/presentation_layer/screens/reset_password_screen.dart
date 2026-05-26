import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:pinput/pinput.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/login_page.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: TextStyle(
        fontSize: 20,
        color: ThemeApp.Foundation_Main_main_500,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeApp.Foundation_Main_main_500.withOpacity(0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: ThemeApp.Foundation_Main_main_500, width: 2),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.red, width: 2),
      ),
    );

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Password".tr(),
                style: TypographyApp.Title_larg_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We sent a verification code to".tr(),
                style: TypographyApp.Title_Mid_Regular.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_200,
                ),
              ),
              Text(
                authController.emailForgetController.text,
                style: TypographyApp.Title_Mid_Regular.copyWith(
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: Pinput(
                  controller: authController.codeResetController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  errorPinTheme: errorPinTheme,
                  showCursor: true,
                  onCompleted: (pin) {
                    debugPrint("Code entered: $pin");
                  },
                ),
              ),
              const SizedBox(height: 20),

              Obx(() {
                bool isVisible =
                    authController.isNewPasswordForgetVisible.value;
                return AppTextFormField(
                  hintText: "Enter new password",
                  labelText: "New Password",
                  obscureText: isVisible,
                  controller: authController.newPasswordResetController,
                  icon: IconApp.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      authController.changePasswordVisibleall(
                        authController.isNewPasswordForgetVisible,
                      );
                    },
                    // edit
                    // icon visible
                    // size icon
                    icon: Icon(
                      isVisible ? Icons.visibility_outlined : Icons.visibility,
                      color: ThemeApp.Foundation_Secendary_grey_100,
                      size: 18.33,
                    ),
                  ),
                  validator: Validators.validatePassword,
                );
              }),

              const SizedBox(height: 15),

              Obx(() {
                bool isVisible =
                    authController.isConfirmNewPasswordForgetVisible.value;
                return AppTextFormField(
                  hintText: "Confirm your new password",
                  labelText: "Confirm Password",
                  obscureText: isVisible,
                  controller: authController.confirmPasswordResetController,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    authController.newPasswordResetController.text,
                  ),
                  icon: IconApp.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      authController.changePasswordVisibleall(
                        authController.isConfirmNewPasswordForgetVisible,
                      );
                    },
                    // edit
                    // icon visible
                    // size icon
                    icon: Icon(
                      isVisible ? Icons.visibility_outlined : Icons.visibility,
                      color: ThemeApp.Foundation_Secendary_grey_100,
                      size: 18.33,
                    ),
                  ),
                );
              }),

              const SizedBox(height: 30),

              Obx(() {
                if (authController.isLoadingResetPassword.value) {
                  // return const Center(child: CircularProgressIndicator());
                  return LoadingAnimationWidget(message: "Wait please...".tr());
                }

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                        authController.resetPassword(
                          () {
                            Get.offAll(() => LoginPage());
                            AppSnackbar.showSuccess(
                              "Your password has been reset successfully",
                            );
                            authController.newPasswordResetController.clear();
                            authController.confirmPasswordResetController.clear();
                            authController.codeResetController.clear();
                            authController.emailForgetController.clear();
                          },
                          (e) {
                            AppSnackbar.showError(e);
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.Foundation_Main_main_500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Reset Password".tr(),
                      style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.whiteBackground,
                    ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
