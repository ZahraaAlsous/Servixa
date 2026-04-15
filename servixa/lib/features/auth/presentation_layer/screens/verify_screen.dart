import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:pinput/pinput.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/const/theme_app.dart';

class VerifyScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  VerifyScreen({super.key});

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

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: ThemeApp.Foundation_Secendary_grey_50,
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Verify your account".tr(),
                  style: TypographyApp.Headline_larg_mid.copyWith(
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                ),
                // edit
                // const SizedBox(height: 8),
                // Text(
                //   "Please enter the code we sent to your email".tr(),
                //   textAlign: TextAlign.center,
                //   style: TypographyApp.Body_mid_Mid.copyWith(
                //     color: ThemeApp.Foundation_Secendary_grey_300.withOpacity(0.7),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                // edit
                // التأكد كرمال يجيبها من ال email فوراً
                autofillHints: null,
                autofocus: true,
                controller: authController.otpController,
                onCompleted: (pin) async {
                  authController.otpController.text = pin;

                  authController.verifyEmail(
                    () {
                      Get.offAll(SuperHomeScreen());
                    },
                    (e) {
                      AppSnackbar.showError(e.toString());
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            Obx(() {
              return authController.isLoading.value
                  ? CircularProgressIndicator()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed:
                                authController.otpController.text.length < 6
                                ? null
                                : () async {
                                    authController.verifyEmail(
                                      () {
                                        Get.offAll(SuperHomeScreen());
                                      },
                                      (e) {
                                        AppSnackbar.showError(e.toString());
                                      },
                                    );
                                  },
                            icon: const Icon(
                              Icons.check_circle_outline,
                              size: 20,
                            ),
                            label: Text("Verify".tr()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeApp.Foundation_Main_main_500,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              // authController.resend(
                              //   () {
                              //     Get.snackbar(
                              //       "Message",
                              //       "Resend a new OTP is done",
                              //     );
                              //   },
                              //   (e) {
                              //     Get.snackbar("Message", e);
                              //   },
                              // );
                            },

                            child: Text(
                              "Resend".tr(),
                              style: TypographyApp.Body_mid_Mid.copyWith(
                                color: ThemeApp.Foundation_Main_main_500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
