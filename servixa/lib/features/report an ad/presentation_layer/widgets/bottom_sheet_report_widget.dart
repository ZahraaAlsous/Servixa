import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/report%20an%20ad/business_layer/report_controller.dart';

class BottomSheetReportWidget extends StatelessWidget {
  final int adsId;
  BottomSheetReportWidget({super.key, required this.adsId});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        reportController.textReportController.clear();
        log("===============================Screen: Clear Data Report");
        return true;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ThemeApp.whiteBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Why are you reporting this ad?",
                        style: TypographyApp.Title_larg_Mid.copyWith(
                          color: ThemeApp.Foundation_Grey_grey_700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppTextAreaWidget(
                        hintText: "Please explain the reason for reporting...",
                        prefixIcon: IconApp.report,
                        controller: reportController.textReportController,
                        validate: Validators.validateReviewAndRequestOrder,
                      ),
                      const SizedBox(height: 30),
                      Obx(() {
                        if (reportController.isSendReport.value) {
                          // return Center(child: CircularProgressIndicator());
                          return LoadingAnimationWidget(
                            message: "Wait please...",
                          );
                        }
                        return _buildActionButtons();
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        children: [
          SvgPicture.asset(
            IconApp.report,
            width: 25,
            height: 25,
            color: ThemeApp.Foundation_Main_main_500,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Report Ad",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.Foundation_Grey_grey_700,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.back();
              reportController.textReportController.clear();
            },
            icon: SvgPicture.asset(
              IconApp.cancel,
              width: 32,
              height: 32,
              color: ThemeApp.Foundation_Secendary_grey_400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: AppOutlinedButtonWidget(
            textContent: "Cancel",
            onPressed: () {
              Get.back();
              reportController.textReportController.clear();
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: reportController.isSendReport.value
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      reportController.addReport(
                        adsId,
                        () {
                          Get.back();
                          AppSnackbar.showSuccess(
                            "Report submitted successfully. We will review it.",
                          );
                          reportController.textReportController.clear();
                        },
                        (e) {
                          AppSnackbar.showError("Failed to submit report: $e");
                        },
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
                    "Submit Report",
                    style: TypographyApp.Body_mid_Mid.copyWith(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
