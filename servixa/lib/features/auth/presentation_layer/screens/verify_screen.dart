import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/const/theme_app.dart';

class VerifyScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
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

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: Color(0xffC4C4C4).withOpacity(0.2)),
    //   borderRadius: BorderRadius.circular(5),
    // );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        // color: ThemeColor.thirdColor.withOpacity(0.2),
        color: ThemeApp.Foundation_Secendary_grey_100,
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your OTP",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Pinput(
                length: 5,
                defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                controller: otpController,
                onCompleted: (pin) async {
                  otpController.text = pin;
                  // await authController.verify(
                  //   pin,
                  //   () {
                  Get.offAll(SuperHomeScreen());
                  // },
                  // (e) {
                  // Get.snackbar("Message", e);
                  // },
                  // );
                },
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              // color:  Colors.red,
              width: MediaQuery.of(context).size.width * 0.90,
              child:
                  // Obx(() {
                  // if (authController.isLoading.value) {
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       color: ThemeColor.primaryColor,
                  //     ),
                  //   );
                  // } else {
                  // return
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          // await authController.verify(
                          //   otpController.text,
                          //   () {
                          Get.offAll(SuperHomeScreen());
                          //   },
                          //   (e) {
                          //     Get.snackbar("Message", e);
                          //   },
                          // );
                        },
                        icon: Icon(Icons.check_circle_outline, size: 20),
                        label: Text("Verify"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeApp.Foundation_Main_main_500,
                          foregroundColor: Colors.white,
                          // minimumSize: Size(130, 50),
                          padding: EdgeInsets.symmetric(
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
                          // minimumSize: Size.zero,
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
                          "Resend",
                          style: TypographyApp.Body_mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                        ),
                      ),
                    ],
                  ),
              // ;
              // }
              // }),
            ),
          ],
        ),
      ),
    );
  }
}
