import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/common/widgets/app_map_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';

class ThirdStepBusinessAccountContactInformationScreen extends StatelessWidget {
  final TextEditingController addressDetailsController =
      TextEditingController();
  final BusiessAccountController busiessAccountController = Get.put(
    BusiessAccountController(),
  );
  ThirdStepBusinessAccountContactInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "City",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppDropdownButtonFormFieldWidget(
          hintText: busiessAccountController.isLoading.value
              ? "Loading cities..."
              : "City",
          onChanged: busiessAccountController.isLoading.value
              ? null
              : (value) {
                  // addAdsController.typeService = value;
                },
          prefixIcon: IconApp.city,
          borderRadio: 16,
          // validator: Validators.validateReviewAndRequestOrder,
          // items: busiessAccountController.isLoading.value
          //     ? [
          //         DropdownMenuItem<String>(
          //           value: null,
          //           enabled: false,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               SizedBox(
          //                 width: 18,
          //                 height: 18,
          //                 child: CircularProgressIndicator(
          //                   strokeWidth: 2,
          //                   color: ThemeApp.Foundation_Main_main_500,
          //                 ),
          //               ),
          //               const SizedBox(width: 8),
          //               Text(
          //                 "Loading cities...",
          //                 style: TypographyApp.Body_mid_Regular,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ]
          //     : busiessAccountController.citiesList.map((city) {
          //         return DropdownMenuItem<CityModel>(
          //           value: city,
          //           child: Row(
          //             children: [
          //               Text(
          //                 city.name,
          //                 // edit
          //                 style: TextStyle(fontSize: 9),
          //               ),
          //             ],
          //           ),
          //         );
          //       }).toList(),

         items: () {
            if (busiessAccountController.isLoading.value) {
              return [
                const DropdownMenuItem<String>(
                  value: null,
                  enabled: false,
                  child: Text("Loading..."),
                ),
              ];
            }

            if (busiessAccountController.citiesList.isEmpty) {
              return [
                const DropdownMenuItem<String>(
                  value: null,
                  enabled: false,
                  child: Text("No cities available"),
                ),
              ];
            }

            return busiessAccountController.citiesList.map((city) {
              return DropdownMenuItem<CityModel>(
                value: city,
                child: Text(city.name),
              );
            }).toList();
          }(),
        
        
          // items: [
          //   DropdownMenuItem<String>(
          //     value: "dolar",
          //     child: Text(
          //       "Dollar \$",
          //       style: TypographyApp.Body_mid_Mid.copyWith(
          //         color: ThemeApp.Foundation_Secendary_grey_400,
          //       ),
          //     ),
          //     alignment: Alignment.center,
          //   ),

          //   DropdownMenuItem<String>(
          //     value: "sp",
          //     child: Text(
          //       "Sp Syrian pounds",
          //       style: TypographyApp.Body_mid_Mid.copyWith(
          //         color: ThemeApp.Foundation_Secendary_grey_400,
          //       ),
          //     ),
          //     alignment: Alignment.center,
          //   ),
          // ],
        ),

        const SizedBox(height: 10),
        Text(
          "Address Detail",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),

        AppTextAreaWidget(
          hintText: "Address Detail",
          prefixIcon: IconApp.Balconies,
          controller: addressDetailsController,
        ),
        const SizedBox(height: 10),

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

        const SizedBox(height: 10),
        AppMapWidget(),
      ],
    );
  }
}
