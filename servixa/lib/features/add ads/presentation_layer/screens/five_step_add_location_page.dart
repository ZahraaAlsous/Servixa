import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_map_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';

class FiveStepAddLocationPage extends StatelessWidget {
  final AddAdsController addAdsController = Get.put(AddAdsController());
  FiveStepAddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: addAdsController.formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address Detail",
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_600,
            ),
          ),

          AppTextAreaWidget(
            hintText: "Address Detail",
            prefixIcon: IconApp.locationPrefix,
            controller: addAdsController.addressDetailsController,
            validate: Validators.validateReviewAndRequestOrder,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(
                IconApp.place,
                color: ThemeApp.Foundation_Main_main_500,
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    addAdsController.currentAddress.value,
                    style: TypographyApp.Body_mid_Regular.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_300,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppMapWidget(
            position: addAdsController.selectedLatLng,
            onLocationSelected: addAdsController.updatePosition,
          ),
        ],
      ),
    );
  }
}
