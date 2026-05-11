import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_ads_business_account_card_widget.dart';

class FirstStepBusinessAccountWidget extends StatelessWidget {
  final AddAdsController addAdsController = Get.put(AddAdsController());
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (businessAccountController.isLoadingBusinessAccounts.value) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                businessAccountController.businessAccountsApprovedList.length,
            itemBuilder: (context, index) {
              final account =
                  businessAccountController.businessAccountsApprovedList[index];
              return AddAdsBusinessAccountCardWidget(
                account: account,
                // isSelected: controller.selectedBusinessAccount.value?.id == account.id,
                // isSelected: false,
                onTap: () {
                  addAdsController.selectedBusinessAccount.value = account;
                },
              );
            },
          );
        }),
      ],
    );
  }
}
