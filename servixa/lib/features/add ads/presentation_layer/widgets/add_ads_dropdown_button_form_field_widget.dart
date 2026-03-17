// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';

// class AddAdsDropdownButtonFormFieldWidget extends StatelessWidget {
//   final String hintText;
//   final void Function(T?)? onChanged;
//   final List<DropdownMenuItem<T>> items;
//   final T? value;

//   AddAdsDropdownButtonFormFieldWidget({
//     super.key,
//     required this.hintText,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(
//       alignment: AlignmentGeometry.center,
//       icon: SvgPicture.asset(
//         IconApp.favorite,
//         width: 50,
//         height: 50,
//         color: Colors.amber,
//       ),
//       style: TypographyApp.Body_mid_Regular.copyWith(
//         color: ThemeApp.Foundation_Secendary_grey_200,
//       ),
//       borderRadius: BorderRadius.circular(16),
//       dropdownColor: ThemeApp.Foundation_Main_main_50,

//       // iconEnabledColor: const Color.fromARGB(255, 26, 103, 165),
//       decoration: InputDecoration(
//         // hintText: "Fixed",
//         hintText: hintText,
//         hintStyle: TypographyApp.Body_mid_Regular.copyWith(
//           color: ThemeApp.Foundation_Secendary_grey_200,
//         ),
//         prefixIcon: Padding(
//           padding: const EdgeInsets.all(12),
//           child: SvgPicture.asset(IconApp.price, width: 24, height: 24),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: ThemeApp.Foundation_Secendary_grey_100),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: ThemeApp.Foundation_Secendary_grey_100),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: Colors.red),
//         ),
//       ),
//       items: [
//         DropdownMenuItem(
//           value: "dolar",
//           child: Text("\$"),
//           alignment: AlignmentGeometry.center,
//         ),
//         DropdownMenuItem(
//           value: "sp",
//           child: Text("Sp"),
//           alignment: AlignmentGeometry.center,
//         ),
//       ],
//       onChanged: onChanged,
//       // (value) {
//       //   addAdsController.typeCoin = value;
//       // },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

// ✅ Generic class with T
class AddAdsDropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final String hintText;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final String prefixIcon;
  final double borderRadio;
  final String? Function(T?)? validator;
  final T? value;

  const AddAdsDropdownButtonFormFieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.items,
    required this.prefixIcon,
    required this.borderRadio,
    this.validator,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
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

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TypographyApp.Body_mid_Regular.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_200,
        ),
        // contentPadding: EdgeInsetsGeometry.only(left:13 , right: 28, top:16 , bottom: 16),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            prefixIcon,
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
