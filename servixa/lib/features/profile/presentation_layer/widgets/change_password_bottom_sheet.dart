import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  ChangePasswordBottomSheet({super.key});

  @override
  State<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final AuthController authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    log("===============================BottomSheet disposed - Cleaning up");
    authController.clearFailedChangePassword();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    // WillPopScope(
    //   onWillPop: () async {
    //     authController.clearFailedChangePassword();
    //     log(
    //       "===============================Screen: Clear Data CreateBusinessAccount",
    //     );
    //     return true;
    //   },
    //   child:
    Container(
      decoration: const BoxDecoration(
        color: ThemeApp.whiteBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 20),

            Obx(() {
              bool isVisible = authController.isOldPasswordVisible.value;
              return AppTextFormField(
                labelText: "Current Password",
                hintText: "Enter your current password",
                icon: IconApp.lock,
                keyboardType: TextInputType.visiblePassword,
                obscureText: authController.isOldPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    authController.changePasswordVisibleall(
                      authController.isOldPasswordVisible,
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
                controller: authController.oldPasswordController,
                validator: Validators.validatePassword,
              );
            }),

            const SizedBox(height: 16),

            Obx(() {
              bool isVisible = authController.isNewPasswordVisible.value;
              return AppTextFormField(
                labelText: "New Password",
                hintText: "Enter new password",
                icon: IconApp.lock,
                keyboardType: TextInputType.visiblePassword,
                obscureText: authController.isNewPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    authController.changePasswordVisibleall(
                      authController.isNewPasswordVisible,
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
                controller: authController.newPasswordController,
                validator: (value) => Validators.validateChangePassword(
                  value,
                  authController.oldPasswordController.text,
                ),
              );
            }),

            const SizedBox(height: 16),

            Obx(() {
              bool isVisible = authController.isConfirmNewPasswordVisible.value;
              return AppTextFormField(
                labelText: "Confirm New Password",
                hintText: "Confirm your new password",
                icon: IconApp.lock,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: authController.isConfirmNewPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    authController.changePasswordVisibleall(
                      authController.isConfirmNewPasswordVisible,
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
                controller: authController.confirmNewPasswordController,
                validator: (value) => Validators.validateConfirmPassword(
                  value,
                  authController.newPasswordController.text,
                ),
              );
            }),

            const SizedBox(height: 30),

            // Submit Button
            Obx(() {
              if (authController.isLoadingChangePassword.value) {
                // return const Center(child: CircularProgressIndicator());
                return LoadingAnimationWidget(message: "Wait please...");
              }
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authController.changePassword(
                        () {
                          Get.back();
                          AppSnackbar.showSuccess(
                            "Password changed successfully!",
                          );

                          authController.clearFailedChangePassword();
                        },
                        (error) {
                          AppSnackbar.showError(error);
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeApp.Foundation_Main_main_500,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Update Password",
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
      // ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SvgPicture.asset(
          IconApp.changePassword,
          width: 25,
          height: 25,
          color: ThemeApp.Foundation_Main_main_500,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "Change Password",
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Grey_grey_700,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Get.back();
            authController.clearFailedChangePassword();
          },
          icon: SvgPicture.asset(
            IconApp.cancel,
            width: 32,
            height: 32,
            color: ThemeApp.Foundation_Secendary_grey_400,
          ),
        ),
      ],
    );
  }
}
