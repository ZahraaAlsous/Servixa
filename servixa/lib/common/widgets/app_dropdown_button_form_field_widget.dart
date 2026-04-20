import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AppDropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final String hintText;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final String? prefixIcon;
  final double borderRadio;
  final String? Function(T?)? validator;
  final T? value;
  final Widget? isChanged;
  final bool isSizeFontSmall;

  const AppDropdownButtonFormFieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.items,
    this.prefixIcon,
    required this.borderRadio,
    this.validator,
    this.value,
    this.isChanged,
    this.isSizeFontSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      // edit 
      // تأكد إذا بالنص أو لا
      alignment: Alignment.center,
      icon: Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          IconApp.arrowUp,
          width: 10,
          height: 10,
          color: ThemeApp.Foundation_Main_main_500,
        ),
      ),
      style: TypographyApp.Body_mid_Regular.copyWith(
        color: ThemeApp.Foundation_Secendary_grey_200,
      ),
      borderRadius: BorderRadius.circular(borderRadio),
      dropdownColor: ThemeApp.Foundation_Main_main_50,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      isExpanded: true,
      isDense: true,
      decoration: InputDecoration(
        hintText: hintText,
        // hintStyle:   TypographyApp.Body_mid_Regular.copyWith(
        //   color: ThemeApp.Foundation_Secendary_grey_200,
        // ),
        // hintStyle: TextStyle(
        //   fontSize: 9,
        //   color: Colors.red
        // ),
        // hint: Text(
        //   hintText,
        //   style: TextStyle(
        //     fontFamily: "Roboto",
        //     fontWeight: FontWeight.w400,
        //     fontSize: 10,
        //     height: 1.4,
        //     letterSpacing: 0,
        //   ),
        // ),
        hintStyle: TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: isSizeFontSmall ? 10 : 12,
          color: ThemeApp.Foundation_Secendary_grey_200,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        prefixIcon:
            isChanged ??
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                prefixIcon!,
                // width: 20,
                // height: 20,
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadio),
          borderSide: BorderSide(color: ThemeApp.Foundation_Secendary_grey_100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadio),
          borderSide: BorderSide(color: ThemeApp.Foundation_Secendary_grey_100),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadio),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),

      items: items,

      onChanged: onChanged,
      validator: validator,
    );
  }
}
