import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/register_page.dart';
import 'package:servixa/features/auth/presentation_layer/screens/verify_screen.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_app_bar_widget.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_elevated_button_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_text_form_field_widget.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AuthAppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(ImageApp.logo),
              width: size.width * 0.674,
              // height: size.height * 0.092,
              height: 86,
            ),

            // const SizedBox(height: 20),
            // edit
            // لازم عرض النص أقل من عرض حقل الإدخال
            AppRichTextWidget(
              firstText: "Login to your ",
              secondText: "Account",
              typographyApp: TypographyApp.Display_small_Mid,
            ),

            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            Text(
              "Welcome back! Log in to continue",
              style: TypographyApp.Title_Mid_Mid.copyWith(
                color: ThemeApp.Foundation_Secendary_grey_400,
              ),
            ),

            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextFormField(
                    labelText: "Email Address",
                    hintText: "example@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    icon: IconApp.email,
                    controller: emailController,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),
                  Obx(() {
                    bool isVisible = authController.isPasswordVisible.value;
                    return AuthTextFormField(
                      labelText: "Password",
                      hintText: "P@12&lV4",
                      icon: IconApp.lock,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: authController.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          authController.changePasswordVisible();
                        },
                        // edit
                        // icon visible
                        // size icon
                        icon: Icon(
                          isVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility,
                          color: ThemeApp.Foundation_Secendary_grey_100,
                          size: 18.33,
                        ),
                      ),
                      controller: passwordController,
                      validator: Validators.validatePassword
                    );
                  }),

                  const SizedBox(height: DimensApp.hightBetweenTextFormField),
                  // edit
                  // get.offall
                  // يروح عال home
                  AuthElevatedButtonWidget(
                    text: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Get.offAll(SuperHomeScreen());
                        Get.offAll(VerifyScreen());
                        log("function login");
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
                  "Don’t have an account ?",
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_600,
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    // minimumSize: Size.zero,
                  ),
                  onPressed: () {
                    Get.offAll(RegisterPage());
                  },

                  child: Text(
                    "Register",
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
