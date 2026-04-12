import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';

class AppCheckboxTermsPoliciesWidget extends StatelessWidget {
  AppCheckboxTermsPoliciesWidget({super.key});
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Checkbox(
            value: authController.isAgreeTermsAndPolicies.value,
            onChanged: (value) {
              authController.changeAgreeTermsAndPolicies();
            },
            activeColor: ThemeApp.Foundation_Statue_Green,
            checkColor: ThemeApp.secondaryButtonBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(
              width: 1.5,
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Text(
          "agreeTermsAndPolicies".tr(),
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
            // edit
            // page terms & policies
            // Get.to(RegisterPage());
          },
          child: Text(
            "termsAndPolicies".tr(),
            style: TypographyApp.Body_mid_Mid.copyWith(
              color: ThemeApp.Foundation_Main_main_500,
            ),
            
          ),
        ),
      ],
    );
  }
}
