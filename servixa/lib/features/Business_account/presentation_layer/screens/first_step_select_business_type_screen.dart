import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/internet_connection_error_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/common/widgets/shimmer/shimmer_loading_widget.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

class FirstStepSelectBusinessTypeScreen extends StatelessWidget {
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  FirstStepSelectBusinessTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      businessAccountController.getCities((e) => AppSnackbar.showError(e));
      businessAccountController.getUserTypes();
    });
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (businessAccountController.isLoadingUserTypes.value) {
        // return Center(child: CircularProgressIndicator());
        // return LoadingAnimationWidget(message: "Loading user type...",);
        return shimmerLoadingGrid(
          widthCard: size.width * 0.2976,
          numItemInRow: 2,
          shrinkWrap: true,
          itemCount: 6,
        );
      }
      if (businessAccountController.hasErrorLoadingUserTypes.value) {
        return InternetConnectionErrorWidget(onPressed: (){
          businessAccountController.getUserTypes();
        });
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
        itemCount: businessAccountController.userTypesList.length,
        itemBuilder: (context, index) {
          final userType = businessAccountController.userTypesList[index];
          return Obx(() {
            final isSelected = businessAccountController.isSelected(userType);

            return InkWell(
              onTap: () => businessAccountController.selectUserType(userType),
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
