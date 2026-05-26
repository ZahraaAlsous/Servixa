// forget_password_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/reset_password_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password".tr(),
                style: TypographyApp.Title_larg_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter your email address and we'll send you a verification code".tr(),
                style: TypographyApp.Title_Mid_Regular.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_200,
                ),
              ),

              const SizedBox(height: 40),
              AppTextFormField(
                hintText: "example@email.com",
                labelText: "Email Address",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                controller: authController.emailForgetController,
                icon: IconApp.email,
                validator: Validators.validateEmail,
              ),

              const SizedBox(height: 30),

              Obx(() {
                if (authController.isLoadingForgetPassword.value) {
                  // return const Center(child: CircularProgressIndicator());
                  return LoadingAnimationWidget(message: "Wait please...".tr(),);
                }
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.forgetPassword(
                          () {
                            Get.to(() => ResetPasswordScreen());
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
                      "Send Reset Code".tr(),
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
