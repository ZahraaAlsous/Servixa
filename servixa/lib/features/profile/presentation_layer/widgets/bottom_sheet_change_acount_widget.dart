// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';
// import 'package:servixa/features/profile/business_later/profile_conttroller.dart';

// class BottomSheetChangeAcountWidget extends StatelessWidget {
//   final ProfileConttroller profileConttroller = Get.put(ProfileConttroller());
//   BottomSheetChangeAcountWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Container(
//       height: size.height * 0.7,
//       decoration: BoxDecoration(
//         color: ThemeApp.whiteBackground,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//       ),
//       child: Column(
//         children: [
//           _buildHeader(),

//           // Expanded(
//           //   child: ListView(
//           // padding: EdgeInsets.symmetric(horizontal: 16),
//           // children: [
//           _buildAccountSection(
//             icon: IconApp.catalogAlt,
//             title: "My Account",
//             type: AccountType.regular,
//           ),
//           SizedBox(height: 10),
//           _buildAccountButton(
//             name: "Ahmad Mohammod",
//             onTap: () => Get.back(result: 'personal'),
//           ),

//           Divider(
//             thickness: 8,
//             color: ThemeApp.Foundation_Secendary_grey_50,
//             height: 30,
//           ),

//           _buildAccountSection(
//             icon: IconApp.business,
//             title: "My Business Accounts",
//             type: AccountType.business,
//           ),
//           SizedBox(height: 10),
//           _buildBusinessDropdown(),
//           SizedBox(height: 20),

//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 10),
//           //   child:
//           // Row(
//           //   children: [
//           //     Expanded(
//           //       child:
//           SizedBox(
//             width: size.width * 0.9,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ThemeApp.Foundation_Main_main_500,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadiusGeometry.circular(16),
//                 ),
//               ),
//               // edit
//               onPressed: () {},
//               child: Text(
//                 "Continue",
//                 style: TypographyApp.Body_mid_Mid.copyWith(
//                   color: ThemeApp.Foundation_Main_yellow_50,
//                 ),
//               ),
//             ),
//           ),
//           // ),

//           // SizedBox(width: 20),

//           // Expanded(
//           //   child:
//           //   ElevatedButton(
//           //     style: ElevatedButton.styleFrom(
//           //       backgroundColor: ThemeApp.Foundation_Main_main_500,
//           //       shape: RoundedRectangleBorder(
//           //         borderRadius: BorderRadiusGeometry.circular(16),
//           //       ),
//           //     ),
//           //     // edit
//           //     onPressed: () {},
//           //     child: Text(
//           //       "Create Account",
//           //       style: TypographyApp.Body_mid_Mid.copyWith(
//           //         color: ThemeApp.Foundation_Main_yellow_50,
//           //       ),
//           //     ),
//           //   ),

//           // ),
//           //   ],
//           // ),
//           // ),
//           // ],
//           // ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             IconApp.catalogAlt,
//             width: 25,
//             height: 25,
//             color: ThemeApp.Foundation_Main_main_300,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               "Chose Account",
//               style: TypographyApp.Title_larg_Mid.copyWith(
//                 color: ThemeApp.Foundation_Grey_grey_700,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => Get.back(),
//             icon: SvgPicture.asset(
//               IconApp.cancel,
//               width: 32,
//               height: 32,
//               color: ThemeApp.Foundation_Secendary_grey_400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAccountSection({
//     required String icon,
//     required String title,
//     required AccountType type,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             icon,
//             width: 25,
//             height: 25,
//             color: ThemeApp.Foundation_Main_main_300,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: TypographyApp.Title_larg_Mid.copyWith(
//                 color: ThemeApp.Foundation_Grey_grey_700,
//               ),
//             ),
//           ),
//           Obx(
//             () => Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: profileConttroller.selectedAdType.value == type
//                       ? ThemeApp.Foundation_Secendary_grey_400
//                       : ThemeApp.Foundation_Secendary_grey_300,
//                   width: profileConttroller.selectedAdType.value == type
//                       ? 5
//                       : 1,
//                 ),
//               ),
//               child: InkWell(
//                 onTap: () {
//                   profileConttroller.selectedAdType.value = type;
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAccountButton({
//     required String name,
//     required VoidCallback onTap,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: ThemeApp.Foundation_Main_main_500,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             name,
//             style: TypographyApp.Title_Mid_Mid.copyWith(
//               color: ThemeApp.Foundation_Main_main_500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBusinessDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: DropdownButtonFormField(
//         // value: value,
//         alignment: Alignment.center,
//         icon: Padding(
//           padding: const EdgeInsets.all(12),
//           child: SvgPicture.asset(
//             IconApp.arrowUp,
//             width: 10,
//             height: 10,
//             color: ThemeApp.Foundation_Main_main_500,
//           ),
//         ),
//         style: TypographyApp.Body_mid_Regular.copyWith(
//           color: ThemeApp.Foundation_Main_main_500,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         dropdownColor: ThemeApp.Foundation_Main_main_50,
//         autovalidateMode: AutovalidateMode.onUserInteraction,

//         decoration: InputDecoration(
//           hintText: "Select Business Account",
//           hintStyle: TypographyApp.Body_mid_Regular.copyWith(
//             // edit
//             // ليش ما عم يطلع اللون نهدي
//             color: ThemeApp.Foundation_Main_main_500,
//           ),
//           // contentPadding: EdgeInsetsGeometry.only(left:13 , right: 28, top:16 , bottom: 16),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(color: ThemeApp.Foundation_Main_main_500),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(color: ThemeApp.Foundation_Main_main_500),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(color: ThemeApp.Foundation_Statue_Red),
//           ),
//         ),

//         items: [
//           DropdownMenuItem<String>(
//             value: "business1",
//             child: Text(
//               "Al Shamel Contracting",
//               style: TypographyApp.Body_mid_Mid.copyWith(
//                 color: ThemeApp.Foundation_Main_main_500,
//               ),
//             ),
//           ),
//           DropdownMenuItem<String>(
//             value: "business2",
//             child: Text(
//               "Tech Solutions LLC",
//               style: TypographyApp.Body_mid_Mid.copyWith(
//                 color: ThemeApp.Foundation_Main_main_500,
//               ),
//             ),
//           ),
//           DropdownMenuItem<String>(
//             value: "business3",
//             child: Text(
//               "Al Rajhi Trading",
//               style: TypographyApp.Body_mid_Mid.copyWith(
//                 color: ThemeApp.Foundation_Main_main_500,
//               ),
//             ),
//           ),
//         ],

//         onChanged: (value) {},
//         // validator: validator,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/profile/business_later/profile_conttroller.dart';

// لا تقم بتعريف AccountType هنا، استخدمه من الـ Controller

class BottomSheetChangeAcountWidget extends StatelessWidget {
  final ProfileConttroller profileConttroller = Get.put(ProfileConttroller());

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
                    type: AccountType
                        .regular, // استخدم AccountType من الـ Controller
                  ),
                  const SizedBox(height: 10),
                  _buildAccountButton(
                    name: "Ahmad Mohammod",
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
                    type: AccountType
                        .business, // استخدم AccountType من الـ Controller
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
                        // معالجة الضغط
                        Get.back(
                          result: profileConttroller.selectedAdType.value,
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
                profileConttroller.selectedAdType.value = type;
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: profileConttroller.selectedAdType.value == type
                      ? ThemeApp.Foundation_Main_main_50
                      : ThemeApp.Foundation_Main_green_50,
                  border: Border.all(
                    color: profileConttroller.selectedAdType.value == type
                        ? ThemeApp.Foundation_Secendary_grey_400
                        : ThemeApp.Foundation_Secendary_grey_300,
                    width: profileConttroller.selectedAdType.value == type
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
