import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/profile/business_later/profile_controller.dart';

class BottomSheetChangeAcountWidget extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController= Get.put(AuthController());

  BottomSheetChangeAcountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      decoration: const BoxDecoration(
        color: ThemeApp.whiteBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildAccountSection(
                    icon: IconApp.catalogAlt,
                    title: "My Account",
                    type: AccountType.regular,
                  ),
                  const SizedBox(height: 10),
                  _buildAccountButton(
                    name: authController.currentUser.value!.name,
                    onTap: () => Get.back(result: 'personal'),
                  ),
                  const Divider(
                    thickness: 8,
                    color: ThemeApp.Foundation_Secendary_grey_50,
                    height: 30,
                  ),
                  _buildAccountSection(
                    icon: IconApp.business,
                    title: "My Business Accounts",
                    type: AccountType.business,
                  ),
                  const SizedBox(height: 10),
                  _buildBusinessDropdown(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeApp.Foundation_Main_main_500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Get.back(
                          result: profileController.selectedAdType.value,
                        );
                      },
                      child: Text(
                        "Continue",
                        style: TypographyApp.Body_mid_Mid.copyWith(
                          color: ThemeApp.Foundation_Main_yellow_50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(
            IconApp.catalogAlt,
            width: 25,
            height: 25,
            color: ThemeApp.Foundation_Main_main_300,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Chose Account",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.Foundation_Grey_grey_700,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
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

  Widget _buildAccountSection({
    required String icon,
    required String title,
    required AccountType type, // استخدم AccountType من الـ Controller
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 25,
            height: 25,
            color: ThemeApp.Foundation_Main_main_300,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.Foundation_Grey_grey_700,
              ),
            ),
          ),
          Obx(
            () => InkWell(
              onTap: () {
                profileController.selectedAdType.value = type;
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: profileController.selectedAdType.value == type
                      ? ThemeApp.Foundation_Main_main_50
                      : ThemeApp.Foundation_Main_green_50,
                  border: Border.all(
                    color: profileController.selectedAdType.value == type
                        ? ThemeApp.Foundation_Secendary_grey_400
                        : ThemeApp.Foundation_Secendary_grey_300,
                    width: profileController.selectedAdType.value == type
                        ? 6
                        : 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountButton({
    required String name,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeApp.Foundation_Main_main_500,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            name,
            style: TypographyApp.Title_Mid_Mid.copyWith(
              color: ThemeApp.Foundation_Main_main_500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: "Select Business Account",
          hintStyle: TypographyApp.Body_mid_Regular.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: ThemeApp.Foundation_Secendary_grey_300,
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
        items: const [
          DropdownMenuItem<String>(
            value: "business1",
            child: Text("Al Shamel Contracting"),
          ),
          DropdownMenuItem<String>(
            value: "business2",
            child: Text("Tech Solutions LLC"),
          ),
          DropdownMenuItem<String>(
            value: "business3",
            child: Text("Al Rajhi Trading"),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            print('Selected business: $value');
          }
        },
      ),
    );
  }
}
