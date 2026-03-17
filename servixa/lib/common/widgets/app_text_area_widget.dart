import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/utils/validators.dart';

class AppTextAreaWidget extends StatelessWidget {
  String hintText;
  String prefixIcon;
  TextEditingController controller;
  void Function(String)? onChange;
  AppTextAreaWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      maxLines: 10,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // hintText: "Enter Details",
        hintText: hintText,
        hintStyle: TypographyApp.Body_mid_Regular.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_200,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: ThemeApp.Foundation_Secendary_grey_200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: ThemeApp.Foundation_Secendary_grey_100,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),

        // prefixIcon: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 15),
        //       child: SvgPicture.asset(
        //         // IconApp.details,
        //         prefixIcon,
        //         width: 20,
        //         height: 20,
        //         color: ThemeApp.Foundation_Main_main_500,
        //       ),
        //     ),
        //   ],
        // ),
        prefixIcon: SizedBox(
          height: 140,
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 10,
                child: SvgPicture.asset(
                  prefixIcon,
                  width: 20,
                  height: 20,
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
            ],
          ),
        ),

        prefixIconConstraints: const BoxConstraints(minWidth: 40, maxWidth: 40),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,

      controller: controller,
      onChanged: onChange,
      // note
      // تأكل إذا حقل الرأي و حقل تفاصيل الطلب مطلوب أو لا
      validator: Validators.validateReviewAndRequestOrder,
    );
  }
}
