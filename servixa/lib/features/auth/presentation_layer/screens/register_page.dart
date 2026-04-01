import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_checkbox_terms_policies_widget.dart';
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
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';
import 'package:country_picker/country_picker.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final Rx<Country?> selectedCountry = Rx<Country?>(
    Country.parse('SY'),
  ); // edit
  // تكون سوريا
  // PhoneNumber phoneNumber = PhoneNumber(isoCode: 'SA');
  // TextEditingController phoneController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AuthAndBoardingAppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          children: [
            AppRichTextWidget(
              firstText: "Create Your ",
              secondText: "Account",
              typographyApp: TypographyApp.Display_small_Mid,
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),

            Text(
              "Fill your information to get started",
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
                        controller: firstNameController,
                        validator: Validators.validateFirstName,
                      ),
                      SizedBox(width: DimensApp.widthBetweenTextFormField),
                      AppTextFormField(
                        labelText: "Last Name",
                        hintText: "Ahmad",
                        icon: IconApp.person,
                        widthTextFormField: 0.444,
                        controller: lastNameController,
                        validator: Validators.validateLastName,
                      ),
                    ],
                  ),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),

                  AppTextFormField(
                    labelText: "Write Email or phone number",
                    hintText: "0911111111 || example@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailPhoneController,
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
                  //     //   // تحقق إضافي حسب طول الرقم
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
                            selectedCountry.value = country;
                          },
                        );
                      },
                      child: Container(
                        height: 48,
                        width: size.width * 0.934,
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
                            if (selectedCountry.value != null)
                              Text(
                                selectedCountry.value!.flagEmoji,
                                style: const TextStyle(fontSize: 24),
                              )
                            else
                              const Icon(Icons.flag, color: Colors.grey),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                selectedCountry.value!.displayName,
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
                      controller: passwordController,
                      validator: Validators.validatePassword,
                    );
                  }),
                  const SizedBox(height: DimensApp.hightBetweenTextFormField),

                  Obx(() {
                    bool isVisible =
                        authController.isConfirmPasswordVisible.value;
                    return AppTextFormField(
                      labelText: "Confirm Password",
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
                      controller: confirmpasswordController,
                      validator: (value) => Validators.validateConfirmPassword(
                        value,
                        passwordController.text,
                      ),
                    );
                  }),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Obx(
                  //       () => Checkbox(
                  //         value: authController.isAgreeTermsAndPolicies.value,
                  //         onChanged: (value) {
                  //           authController.changeAgreeTermsAndPolicies();
                  //         },
                  //         activeColor: ThemeApp.Foundation_Statue_Green,
                  //         checkColor: ThemeApp.secondaryButtonBg,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         side: BorderSide(
                  //           width: 1.5,
                  //           color: ThemeApp.Foundation_Secendary_grey_600,
                  //         ),
                  //         visualDensity: VisualDensity.compact,
                  //         materialTapTargetSize:
                  //             MaterialTapTargetSize.shrinkWrap,
                  //       ),
                  //     ),
                  //     Text(
                  //       "I agree with ",
                  //       style: TypographyApp.Body_mid_Mid.copyWith(
                  //         color: ThemeApp.Foundation_Secendary_grey_600,
                  //       ),
                  //     ),
                  //     TextButton(
                  //       style: ElevatedButton.styleFrom(
                  //         padding: EdgeInsets.zero,
                  //         // minimumSize: Size.zero,
                  //       ),
                  //       onPressed: () {
                  //         Get.to(RegisterPage());
                  //       },
                  //       child: Text(
                  //         "terms & policies",
                  //         style: TypographyApp.Body_mid_Mid.copyWith(
                  //           color: ThemeApp.Foundation_Main_main_500,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  AppCheckboxTermsPoliciesWidget(),

                  // edit
                  // add function register
                  Obx(
                    () => AuthElevatedButtonWidget(
                      colorButton: !authController.isAgreeTermsAndPolicies.value
                          ? ThemeApp.Foundation_Secendary_grey_200
                          : null,
                      text: "Register",
                      onPressed: authController.isAgreeTermsAndPolicies.value
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                // edit
                                // تابع تسجيل حساب
                                // Get.offAll(SuperHomeScreen());
                                Get.to(VerifyScreen());
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
                  "Already have an account ?",
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
                    Get.offAll(LoginPage());
                  },

                  child: Text(
                    "Login",
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
