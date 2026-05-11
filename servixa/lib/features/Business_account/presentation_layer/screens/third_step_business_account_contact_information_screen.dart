import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/common/widgets/app_map_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';

class ThirdStepBusinessAccountContactInformationScreen extends StatelessWidget {
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  ThirdStepBusinessAccountContactInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: businessAccountController.formKeys[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "City",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),
          Obx(() {
            List<DropdownMenuItem<CityModel>> menuItems = [];

            if (businessAccountController.citiesList.isNotEmpty) {
              menuItems = businessAccountController.citiesList.map((city) {
                return DropdownMenuItem<CityModel>(
                  value: city,
                  child: Text(city.name),
                );
              }).toList();
            }
            CityModel? selectedValue =
                businessAccountController.selectedCity.value;

            if (selectedValue != null &&
                !businessAccountController.citiesList.contains(selectedValue)) {
              selectedValue = null;
            }

            return AppDropdownButtonFormFieldWidget(
              value: selectedValue,
              items: menuItems.isEmpty ? [] : menuItems,
              hintText: businessAccountController.isLoadingCities.value
                  ? "Loading..."
                  : "City",
              onChanged: (value) {
                if (value is CityModel) {
                  businessAccountController.selectCity(value);
                }
              },
              borderRadio: 16,
              prefixIcon: IconApp.city,
            );
          }),
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
            controller: businessAccountController.addressDetailsController,
          ),
          const SizedBox(height: 10),

          // Row(
          //   children: [
          //     SvgPicture.asset(
          //       IconApp.place,
          //       color: ThemeApp.Foundation_Main_main_500,
          //     ),
          //     // edit
          //     Text(
          //       "742 Evergreen Terrace, Springfield",
          //       style: TypographyApp.Body_mid_Regular.copyWith(
          //         color: ThemeApp.Foundation_Secendary_grey_300,
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              SvgPicture.asset(
                IconApp.place,
                color: ThemeApp.Foundation_Main_main_500,
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    businessAccountController.currentAddress.value,
                    style: TypographyApp.Body_mid_Regular.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_300,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AppMapWidget(
            position: businessAccountController.selectedLatLng,
            onLocationSelected: businessAccountController.updatePosition,
          ),
        ],
      ),
    );
  }
}
