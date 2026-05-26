import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/orders/business_later/order_controller.dart';

class BottomSheetAddOrderWidget extends StatelessWidget {
  final int adId;
  BottomSheetAddOrderWidget({super.key, required this.adId});
  final _formKey = GlobalKey<FormState>();
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        orderController.cleanFailed();
        log("===============================Screen: Clear Data CreateOrder");
        return true;
      },
      child: FractionallySizedBox(
        heightFactor: 0.86,
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: ThemeApp.whiteBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset(
                          IconApp.catalogAlt,
                          width: 25,
                          height: 25,
                          color: ThemeApp.Foundation_Main_main_300,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          "Request Catalog".tr(),
                          style: TypographyApp.Title_larg_Mid.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                            orderController.cleanFailed();
                          },
                          icon: SvgPicture.asset(
                            IconApp.cancel,
                            width: 32,
                            height: 32,
                            color: ThemeApp.Foundation_Secendary_grey_400,
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),

                  // const SizedBox(height: 20),
                  // Expanded(
                  //   flex: 1,
                  //  child:
                  Text(
                    "Need By Date".tr(),
                    style: TypographyApp.Title_Mid_Mid.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // ),
                  const SizedBox(height: 5),
                  // Expanded(
                  //   flex: 2,
                  //   child:
                  TextFormField(
                    controller: orderController.fromDateController,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hint: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // note
                          // فيها مشكلة من ال figma
                          // SvgPicture.asset(
                          //   IconApp.clarityDateLine,
                          //   width: 18,
                          //   height: 18,
                          //   color: ThemeApp.Foundation_Main_main_500,
                          // ),
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          Text(
                            " Select date".tr(),
                            style: TypographyApp.Body_mid_Regular.copyWith(
                              color: ThemeApp.Foundation_Secendary_grey_200,
                            ),
                          ),
                        ],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: ThemeApp.Foundation_Secendary_grey_100,
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
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                    ),
                    onTap: () async {
                      final DateTime tomorrow = DateTime.now().add(
                        const Duration(days: 1),
                      );
                      final DateTime tomorrowDate = DateTime(
                        tomorrow.year,
                        tomorrow.month,
                        tomorrow.day,
                      );
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        // initialDate: DateTime.now(),
                        // firstDate: DateTime.now(),
                        initialDate: tomorrowDate,
                        firstDate: tomorrowDate,
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: ThemeApp.Foundation_Main_main_500,
                                onPrimary: ThemeApp.Foundation_Main_main_50,
                                surface: ThemeApp.whiteBackground,
                                onSurface: ThemeApp.Foundation_Main_main_500,
                              ),
                              dialogBackgroundColor: ThemeApp.whiteBackground,
                            ),
                            child: child!,
                          );
                        },
                      );

                      // if (pickedDate != null) {
                      //   orderController.fromDateController.text =
                      //       // "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      //       "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
                      // }
                      if (pickedDate != null) {
                        final String year = pickedDate.year.toString();
                        final String month = pickedDate.month
                            .toString()
                            .padLeft(2, '0');
                        final String day = pickedDate.day.toString().padLeft(
                          2,
                          '0',
                        ); // 1 → 01

                        orderController.fromDateController.text =
                            "$year-$month-$day";
                      }
                    },

                    // validator: Validators.validateDate,
                  ),
                  // ),
                  const SizedBox(height: 10),
                  Text(
                    "Business Account".tr(),
                    style: TypographyApp.Title_Mid_Mid.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),

                  _buildBusinessDropdown(),
                  const SizedBox(height: 10),
                  Text(
                    "Quantity".tr(),
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),

                  AppTextFormField(
                    hintText: "Quantity",
                    icon: IconApp.quantity,
                    keyboardType: TextInputType.number,
                    // edit
                    validator: Validators.validateReviewAndRequestOrder,
                    controller: orderController.quantityController,
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Details".tr(),
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),

                  AppTextAreaWidget(
                    hintText: "Enter Details",
                    prefixIcon: IconApp.details,
                    controller: orderController.detailsController,
                    validate: Validators.validateNotRequiredButInput,
                  ),
                  const SizedBox(height: 10),

                  // const SizedBox(height: 20),
                  Obx(() {
                    if (orderController.isSendOrder.value) {
                      // return Center(child: CircularProgressIndicator());
                      return LoadingAnimationWidget(message: "Wait please...".tr());
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: ThemeApp.Foundation_Main_main_500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              Get.back();
                              orderController.cleanFailed();
                            },
                            child: Text(
                              "Cancel".tr(),
                              style: TypographyApp.Body_mid_Mid.copyWith(
                                color: ThemeApp.Foundation_Main_main_500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeApp.Foundation_Main_main_500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                orderController.addOrder(
                                  adId,
                                  () {
                                    Get.back();
                                    orderController.cleanFailed();
                                    AppSnackbar.showSuccess(
                                      "Your order has been received successfully!",
                                    );
                                  },
                                  (e) {
                                    AppSnackbar.showError(e);
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Submit".tr(),
                              style: TypographyApp.Body_mid_Mid.copyWith(
                                color: ThemeApp.Foundation_Main_yellow_50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessDropdown() {
    return Obx(() {
      var items = businessAccountController.businessAccountsApprovedList;

      return DropdownButtonFormField<dynamic>(
        value:
            items.any(
              (item) =>
                  item.id == orderController.selectedBusinessAccountId.value,
            )
            ? orderController.selectedBusinessAccountId.value
            : null,
        validator: (value) =>
            Validators.validateDropDown(type: "account", value: value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: businessAccountController.isLoadingBusinessAccounts.value
              ? "Loading business accounts...".tr()
              : "Select Business Account".tr(),
          hintStyle: TypographyApp.Body_mid_Regular.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: ThemeApp.Foundation_Secendary_grey_100,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: ThemeApp.Foundation_Main_main_500),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              IconApp.business,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                ThemeApp.Foundation_Main_main_500,
                BlendMode.srcIn,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            IconApp.arrowUp,
            width: 10,
            height: 10,
            color: ThemeApp.Foundation_Main_main_500,
          ),
        ),
        style: TypographyApp.Body_mid_Regular.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_700,
        ),
        borderRadius: BorderRadius.circular(16),
        dropdownColor: ThemeApp.whiteBackground,

        items: items.map((account) {
          return DropdownMenuItem<dynamic>(
            value: account.id,
            child: Text(account.businessNameEnglish),
          );
        }).toList(),
        onChanged: (val) {
          orderController.selectedBusinessAccountId.value = val;
        },
      );
    });
  }
}
