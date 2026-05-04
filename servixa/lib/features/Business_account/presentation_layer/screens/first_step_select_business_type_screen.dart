import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

class FirstStepSelectBusinessTypeScreen extends StatelessWidget {
  final BusiessAccountController busiessAccountController = Get.put(
    BusiessAccountController(),
  );
  FirstStepSelectBusinessTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (busiessAccountController.isLoadingUserTypes.value) {
        return Center(child: CircularProgressIndicator());
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 32,
          crossAxisSpacing: 32,
          childAspectRatio: 182 / 113,
        ),
        itemCount: busiessAccountController.userTypesList.length,
        itemBuilder: (context, index) {
          final userType = busiessAccountController.userTypesList[index];
          return Obx(() {
            final isSelected = busiessAccountController.isSelected(userType);

            return InkWell(
              onTap: () => busiessAccountController.selectUserType(userType),
              child: Container(
                width: size.width * 0.2976,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ThemeApp.Foundation_Main_main_100
                      : ThemeApp.Foundation_Main_yellow_50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(IconApp.Balconies),
                    // SvgPicture.network(
                    //   userType.icon!.url,
                    // ),
                    Text(
                      userType.name,
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      );
    });
  }
}
