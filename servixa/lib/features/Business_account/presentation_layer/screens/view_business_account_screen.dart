import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';

class ViewBusinessAccountScreen extends StatefulWidget {
  const ViewBusinessAccountScreen({super.key});

  @override
  State<ViewBusinessAccountScreen> createState() =>
      _ViewBusinessAccountScreenState();
}

class _ViewBusinessAccountScreenState extends State<ViewBusinessAccountScreen> {
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );

  @override
  void initState() {
    businessAccountController.getBusinessAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(
        title: Text(
          "My business account",
          style: TypographyApp.Title_larg_Mid.copyWith(
            color: ThemeApp.Foundation_Main_main_500,
          ),
        ),
      ),
      body: Obx(() {
        if (businessAccountController.isLoadingBusinessAccounts.value) {
          // return Center(child: CircularProgressIndicator());
          return LoadingAnimationWidget(
            message: "Loading business accounts...",
            showLogo: true,
          );
        }
        if (businessAccountController.businessAccountsList.isEmpty) {
          return Center(child: Text("data"));
        }
        return ListView.builder(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: size.width * DimensApp.spaceHorizontalScreen,
          ),
          itemCount: businessAccountController.businessAccountsList.length,
          itemBuilder: (context, indexAccount) {
            BusinessAccountModel account =
                businessAccountController.businessAccountsList[indexAccount];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: account.status == "approved"
                      ? ThemeApp.Foundation_Main_main_500
                      : account.status == "rejected"
                      ? ThemeApp.Foundation_Statue_Red
                      : ThemeApp.Foundation_Secendary_grey_100,
                  width: 2,
                ),
                color: account.status == "approved"
                    ? ThemeApp.Foundation_Main_main_50
                    : ThemeApp.whiteBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        account.businessNameEnglish,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        account.typeBusinessAccount.name,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: TypographyApp.Body_mid_Mid,
                      children: [
                        TextSpan(
                          text: account.status,
                          style: TextStyle(
                            color: account.status == "approved"
                                ? ThemeApp.Foundation_Main_main_500
                                : account.status == "rejected"
                                ? ThemeApp.Foundation_Statue_Red
                                : Colors.grey[600],
                          ),
                        ),
                        TextSpan(
                          text: account.status == "approved"
                              ? " at " + account.approvedAt.toString()
                              : account.status == "rejected"
                              ? " ,The resons is: " + account.rejectReason!
                              : "",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
