import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController addressDetailsController =
      TextEditingController();
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRichTextWidget(
              firstText: "Update ",
              secondText: "Profile",
              typographyApp: TypographyApp.Title_larg_Mid,
            ),
            SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

            Row(
              children: [
                AppTextFormField(
                  labelText: "First Name",
                  hintText: "Ahmad",
                  icon: IconApp.person,
                  widthTextFormField: 0.444,
                  // controller: firstNameController,
                  // validator: Validators.validateFirstName,
                ),
                const SizedBox(width: DimensApp.widthBetweenTextFormField),
                AppTextFormField(
                  labelText: "Last Name",
                  hintText: "Ahmad",
                  icon: IconApp.person,
                  widthTextFormField: 0.444,
                  // controller: lastNameController,
                  // validator: Validators.validateLastName,
                ),
              ],
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),

            AppTextFormField(
              labelText: "Email Address",
              hintText: "example@gmail.com",
              keyboardType: TextInputType.emailAddress,
              icon: IconApp.email,
              // controller: emailPhoneController,
              // validator: Validators.validateEmailOrPhone,
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            AppTextFormField(
              labelText: "Phone Number",
              hintText: "+963 11111111",
              keyboardType: TextInputType.phone,
              // edit
              // icon
              icon: IconApp.phone,
              // controller: emailPhoneController,
              // validator: Validators.validateEmailOrPhone,
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            AppDropdownButtonFormFieldWidget(
              hintText: "City",
              // edit
              onChanged: (value) {
                // addAdsController.typeService = value;
              },
              // edit
              prefixIcon: IconApp.suggestion,
              borderRadio: 16,
              // edit
              // validator: Validators.validateReviewAndRequestOrder,
              // edit
              items: [
                DropdownMenuItem<String>(
                  value: "dolar",
                  child: Text(
                    "Dollar \$",
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_400,
                    ),
                  ),
                  alignment: Alignment.center,
                ),

                DropdownMenuItem<String>(
                  value: "sp",
                  child: Text(
                    "Sp Syrian pounds",
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_400,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            Row(
              children: [
                SvgPicture.asset(
                  IconApp.place,
                  color: ThemeApp.Foundation_Main_main_500,
                ),
                // edit
                Text(
                  "742 Evergreen Terrace, Springfield",
                  style: TypographyApp.Body_mid_Regular.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),

            AppTextAreaWidget(
              hintText: "Address Detail",
              // edit
              prefixIcon: IconApp.Balconies,
              controller: addressDetailsController,
            ),
            const SizedBox(height: DimensApp.hightBetweenTextFormField),
            SizedBox(
              width: size.width * 0.93,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: ThemeApp.Foundation_Main_main_500,
                ),
                onPressed: () {},

                child: Text(
                  "Update",
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Main_yellow_50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
