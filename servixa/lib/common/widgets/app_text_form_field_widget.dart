import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
class AppTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final String? icon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final double? widthTextFormField;
  final Color? colorIconPrefix;
  final double? sizeIconPrefix;
  final int? minLines;
  final int? maxLines;
  final void Function(String)? onChanged;
  final Widget? prefix;

  const AppTextFormField({
    super.key,
    this.labelText,
    required this.hintText,
    this.icon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.controller,
    this.obscureText,
    this.suffixIcon,
    this.widthTextFormField,
    this.colorIconPrefix,
    this.sizeIconPrefix,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.prefix
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final size = Get.width;

    return SizedBox(
      width: size * (widthTextFormField ?? 0.934),
      child: TextFormField(
        minLines: minLines ?? null,
        maxLines: maxLines ?? 1,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText.tr(),
          labelText: labelText?.tr(),
          labelStyle: TypographyApp.Body_mid_Regular.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_200,
          ),
          hintStyle: TypographyApp.Body_mid_Regular.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_200,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 1,
              color: ThemeApp.Foundation_Secendary_grey_100,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
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
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),

          prefixIcon: prefix ?? (icon != null
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    icon!,
                    width: sizeIconPrefix ?? 20,
                    height: sizeIconPrefix ?? 20,
                    colorFilter: ColorFilter.mode(
                      colorIconPrefix ?? ThemeApp.Foundation_Main_main_500,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                )
              : null),

          suffixIcon: suffixIcon,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
      ),
    );
  }
}
