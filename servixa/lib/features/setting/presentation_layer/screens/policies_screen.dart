import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_nothing_widget.dart';
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/setting/business_layer/policy_controller.dart';
import 'package:servixa/features/setting/data_layer/models/policy_model.dart';

class PoliciesScreen extends StatelessWidget {
  PoliciesScreen({super.key});

  final PolicyController _policyController = Get.put(PolicyController());

  @override
  Widget build(BuildContext context) {
    if (_policyController.policies.isEmpty &&
        !_policyController.isLoadingPolicies.value) {
      _policyController.loadPolicies();
    }

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBar(
        title: Obx(
          () => Text(
            _getSelectedTabTitle(),
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Main_main_500,
            ),
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ThemeApp.linearBackground, ThemeApp.whiteBackground],
            ),
          ),
          // child: child,
        ),
        elevation: 0,

        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: ThemeApp.Foundation_Main_main_500,
        //   ),
        //   onPressed: () => Get.back(),
        // ),
      ),
      body: Obx(() {
        if (_policyController.isLoadingPolicies.value) {
          return const Center(
            child: LoadingAnimationWidget(message: "Loading..."),
            // child: ShimmerPolicyWidget(),
          );
        }

        if (_policyController.hasError.value) {
          return Center(
            child: InternetConnectionErrorWidget(
              onPressed: () => _policyController.loadPolicies(),
            ),
          );
        }

        if (_policyController.policies.isEmpty) {
          return Center(child: AppNothingWidget());
        }

        return Column(
          children: [
            _buildTabBar(),
            // const SizedBox(height: 16),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [_buildPolicyContent()],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTabBar() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ThemeApp.Foundation_Secendary_grey_50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildTabItem(
              title: "Privacy Policy".tr(),
              index: 0,
              isSelected: _policyController.selectedTabIndex.value == 0,
            ),
            _buildTabItem(
              title: "Terms & Conditions".tr(),
              index: 1,
              isSelected: _policyController.selectedTabIndex.value == 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String title,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _policyController.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? ThemeApp.Foundation_Main_main_500
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TypographyApp.Body_mid_Mid.copyWith(
              color: isSelected
                  ? Colors.white
                  : ThemeApp.Foundation_Secendary_grey_400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyContent() {
    return Obx(() {
      String content = _policyController.selectedTabIndex.value == 0
          ? _getPolicyContent("privacy_policy")
          : _getPolicyContent("terms_and_conditions");

      if (content.isEmpty) {
        return Center(
          child: AppNothingWidget(),
        );
      }

      return Html(
        data: content,
        style: {
          "body": Style(
            fontSize: FontSize(14.0),
            color: Colors.black87,
            fontFamily: "Roboto",
            lineHeight: LineHeight(1.6),
          ),
          "p": Style(
            // margin: Margins.only(bottom: Margin(12)),
            margin: Margins.only(bottom: 12),
          ),
          "strong": Style(
            fontWeight: FontWeight.bold,
            color: ThemeApp.Foundation_Main_main_500,
          ),
          "h3": Style(
            fontSize: FontSize(18.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(top: 16, bottom: 8),
          ),
          "a": Style(
            color: Colors.blue,
            textDecoration: TextDecoration.underline,
          ),
          "ul": Style(padding: HtmlPaddings.only(left: 20)),
          "li": Style(margin: Margins.only(bottom: 4)),
        },
      );
    });
  }

  String _getPolicyContent(String key) {
    try {
      final policy = _policyController.policies.firstWhere(
        (policy) => policy.key == key,
        orElse: () => PolicyModel(key: "", value: ""),
      );
      return policy.value;
    } catch (e) {
      return "";
    }
  }

  String _getSelectedTabTitle() {
    return _policyController.selectedTabIndex.value == 0
        ? "Privacy Policy".tr()
        : "Terms & Conditions".tr();
  }
}
