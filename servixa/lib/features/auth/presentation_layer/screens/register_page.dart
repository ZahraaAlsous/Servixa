import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_checkbox_terms_policies_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/auth/presentation_layer/screens/login_page.dart';
import 'package:servixa/features/auth/presentation_layer/screens/verify_screen.dart';
import 'package:servixa/common/widgets/auth_and_boarding_app_bar_widget.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_elevated_button_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  RegisterPage({super.key});

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
        padding: EdgeInsetsGeometry.symmetric(
          // horizontal: size.width * DimensApp.spaceHorizontalScreen,
          horizontal: size * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          children: [
            const AppRichTextWidget(
              firstText: "TitleRegister",
              secondText: "Account",
              typographyApp: TypographyApp.Display_small_Mid,
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),

            Text(
              "TextRegister".tr(),
              style: TypographyApp.Title_Mid_Mid.copyWith(
                color: ThemeApp.Foundation_Secendary_grey_400,
              ),
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextFormField(
                        labelText: "First Name",
                        hintText: "Ahmad",
                        icon: IconApp.person,
                        widthTextFormField: 0.444,
                        controller: authController.firstNameController,
                        validator: Validators.validateFirstName,
                      ),
                      const SizedBox(
                        width: DimensApp.widthBetweenTextFormField,
                      ),
                      AppTextFormField(
                        labelText: "Last Name",
                        hintText: "Ahmad",
                        icon: IconApp.person,
                        widthTextFormField: 0.444,
                        controller: authController.lastNameController,
                        validator: Validators.validateLastName,
                      ),
                    ],
                  ),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),

                  AppTextFormField(
                    labelText: "Write Email or phone number",
                    hintText: "0911111111 || example@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    controller: authController.emailPhoneController,
                    validator: Validators.validateEmailOrPhone,
                  ),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),

                  // Container(
                  //   height: 48,
                  //   width: size.width * 0.934,
                  //   margin: EdgeInsetsGeometry.symmetric(vertical: 20),

                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(16),
                  //     border: BoxBorder.all(
                  //       color: ThemeApp.Foundation_Secendary_grey_100,
                  //       width: 1,
                  //     ),
                  //   ),
                  //   child: InternationalPhoneNumberInput(
                  //     hintText: "Enter your phone (optional)",
                  //     onInputChanged: (PhoneNumber number) {
                  //       phoneNumber = number;
                  //     },
                  //     onInputValidated: (bool isValid) {
                  //       print('Is valid: $isValid');
                  //     },

                  //     selectorConfig: const SelectorConfig(
                  //       selectorType: PhoneInputSelectorType.DIALOG,
                  //       useEmoji: true,
                  //       // leadingSelector: true,
                  //       leadingPadding: 10,
                  //       setSelectorButtonAsPrefixIcon: true,
                  //       trailingSpace: false,
                  //     ),
                  //     initialValue: phoneNumber,
                  //     textFieldController: phoneController,
                  //     formatInput: true,
                  //     inputBorder: InputBorder.none,
                  //     keyboardType: const TextInputType.numberWithOptions(
                  //       signed: true,
                  //       decimal: true,
                  //     ),
                  //     // validator: (String? value) {
                  //     //   if (value == null || value.isEmpty) {
                  //     //     return 'Phone number is required';
                  //     //   }
                  //     //   if (value.length < 9) {
                  //     //     return 'Phone number is too short';
                  //     //   }
                  //     //   return null;
                  //     // },
                  //   ),
                  // ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            authController.selectedCountry.value = country;
                          },
                        );
                      },
                      child: Container(
                        height: 48,
                        // width: size.width * 0.934,
                        width: size * 0.934,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ThemeApp.Foundation_Secendary_grey_100,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (authController.selectedCountry.value != null)
                              Text(
                                authController.selectedCountry.value!.flagEmoji,
                                style: const TextStyle(fontSize: 24),
                              )
                            else
                              const Icon(Icons.flag, color: Colors.grey),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                authController
                                    .selectedCountry
                                    .value!
                                    .displayName,
                                style: TypographyApp.Body_mid_Regular,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: DimensApp.hightBetweenTextFormField),

                  Obx(() {
                    bool isVisible = authController.isPasswordVisible.value;
                    return AppTextFormField(
                      labelText: "Password",
                      hintText: "P@12&lV4",
                      icon: IconApp.lock,
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
                      controller: authController.passwordRegisterController,
                      validator: Validators.validatePassword,
                    );
                  }),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),

                  Obx(() {
                    bool isVisible =
                        authController.isConfirmPasswordVisible.value;
                    return AppTextFormField(
                      labelText: "Confirm",
                      hintText: "P@12&lV4",
                      icon: IconApp.lock,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText:
                          authController.isConfirmPasswordVisible.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          authController.changeConfirmPasswordVisible();
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
                      controller: authController.confirmPasswordController,
                      validator: (value) => Validators.validateConfirmPassword(
                        value,
                        authController.passwordRegisterController.text,
                      ),
                    );
                  }),
                  AppCheckboxTermsPoliciesWidget(),

                  Obx(
                    () => authController.isLoading.value
                        ? CircularProgressIndicator()
                        : AuthElevatedButtonWidget(
                            colorButton:
                                !authController.isAgreeTermsAndPolicies.value
                                ? ThemeApp.Foundation_Secendary_grey_200
                                : null,
                            text: "Register",
                            onPressed:
                                authController.isAgreeTermsAndPolicies.value
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      log(
                                        "******************************Click REGISTER",
                                      );
                                      authController.register(
                                        () {
                                          Get.to(VerifyScreen());
                                        },
                                        (e) {
                                          AppSnackbar.showError(e.toString());
                                        },
                                      );
                                    }
                                  }
                                : null,
                          ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ?".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_600,
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  onPressed: () {
                    Get.offAll(() => LoginPage());
                  },

                  child: Text(
                    "Login".tr(),
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
