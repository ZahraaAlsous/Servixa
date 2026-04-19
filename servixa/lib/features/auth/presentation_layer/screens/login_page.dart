import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/register_page.dart';
import 'package:servixa/common/widgets/auth_and_boarding_app_bar_widget.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_elevated_button_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final size = Get.width;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: const AuthAndBoardingAppBarWidget(
        whereGo: const SuperHomeScreen(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          children: [
            Image(
              image: const AssetImage(ImageApp.logo),
              // width: size.width * 0.674,
              width: size * 0.674,
              // height: size.height * 0.092,
              height: 86,
            ),

            // const SizedBox(height: 20),
            // edit
            // لازم عرض النص أقل من عرض حقل الإدخال
            const AppRichTextWidget(
              firstText: "TitleLogin",
              secondText: "Account",
              typographyApp: TypographyApp.Display_small_Mid,
            ),

            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            Text(
              "TextLogin".tr(),
              style: TypographyApp.Title_Mid_Mid.copyWith(
                color: ThemeApp.Foundation_Secendary_grey_400,
              ),
            ),

            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    labelText: "Email Address",
                    hintText: "example@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    icon: IconApp.email,
                    // controller: emailController,
                    controller: authController.emailLoginController,
                    // validator: Validators.validateEmail,
                    validator: Validators.validateEmailOrPhone,
                  ),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),
                  Obx(() {
                    bool isObscured = authController.isPasswordVisible.value;
                    return AppTextFormField(
                      labelText: "Password",
                      hintText: "P@12&lV4",
                      icon: IconApp.lock,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscured,
                      maxLines: 1,
                      suffixIcon: IconButton(
                        onPressed: () {
                          authController.changePasswordVisible();
                        },
                        // edit
                        // icon visible
                        // size icon
                        icon: Icon(
                          isObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility,
                          color: ThemeApp.Foundation_Secendary_grey_100,
                          size: 18.33,
                        ),
                      ),
                      // controller: passwordController,
                      controller: authController.passwordLoginController,
                      validator: Validators.validatePassword,
                    );
                  }),

                  const SizedBox(height: DimensApp.hightBetweenTextFormField),
                  // edit
                  // get.offall
                  // يروح عال home?
                  // لازم laoding و جرب const
                  authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : AuthElevatedButtonWidget(
                          text: "Login",
                          onPressed: authController.isLoading.value ? null :  () {
                            if (_formKey.currentState!.validate()) {
                              log("******************************Click LOGIN");
                              authController.login(
                                () {
                                  Get.offAll(SuperHomeScreen());
                                },
                                (e) {
                                  AppSnackbar.showError(e.toString());
                                },
                              );
                            }
                            // Get.offAll(page)
                          },
                        ),
                ],
              ),
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account ?".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_600,
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Get.offAll(() => RegisterPage());
                  },

                  child: Text(
                    "Register".tr(),
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
