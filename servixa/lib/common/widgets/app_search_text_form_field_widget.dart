import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';

class AppSearchTextFormFieldWidget extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  double? radio;
  double? widthTextForm;

  AppSearchTextFormFieldWidget({super.key, this.radio, this.widthTextForm});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: widthTextForm ?? size.width * 0.913,
      // height: size.height * 0.051,
      child: TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search any item...",
          enabledBorder: OutlineInputBorder(
            // gapPadding: 50,
            borderRadius: BorderRadius.circular(radio ?? 8),
            borderSide: BorderSide(
              width: 1,
              color: ThemeApp.Foundation_Secendary_grey_200,
            ),
          ),
          // edit
          // تابع بحث
          prefixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              IconApp.search,
              width: 16.5,
              height: 16.5,
              color: ThemeApp.Foundation_Secendary_grey_200,
            ),
          ),
          suffixIcon: IconButton(
            // edit
            // تابع فلترة
            onPressed: () {},
            icon: SvgPicture.asset(
              IconApp.tune,
              width: 20,
              height: 20,
              color: ThemeApp.Foundation_Secendary_grey_200,
            ),
            // Icon(
            //   Icons.tune,
            //   color: ThemeApp.Foundation_Secendary_grey_200,
            //   size: 20,
            // ),
          ),
          contentPadding: EdgeInsetsGeometry.symmetric(
            horizontal: 25,
            vertical: 13,
          ),
        ),
        // edit
        // إعمل validator? التطبيقات الضخمة ما بتعمل
      ),
    );
  }
}
