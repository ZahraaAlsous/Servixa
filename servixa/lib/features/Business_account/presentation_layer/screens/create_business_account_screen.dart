import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/Second_step_business_account_details_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/first_step_select_business_type_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/four_step_business_account_document_screen.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/third_step_business_account_contact_information_screen.dart';

class CreateBusinessAccountScreen extends StatelessWidget {
  RxInt _currentStep = 0.obs;

  final List<String> _stepTitles = [
    "Select a Business Profile Type",
    "Enter The Business Details",
    "Enter Contact Information",
    "Upload Supporting Document",
  ];

  final List<String> _stepIcon = [
    IconApp.businessProfileType,
    IconApp.businessDetails,
    IconApp.contactInformation,
    IconApp.businessProfileType,
  ];

  final List<Widget> _pages = [
    FirstStepSelectBusinessTypeScreen(),
    SecondStepBusinessAccountDetailsScreen(),
    ThirdStepBusinessAccountContactInformationScreen(),
    FourStepBusinessAccountDocumentScreen(),
  ];

  CreateBusinessAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: size.width * DimensApp.spaceHorizontalScreen),
        child: Column(
          children: [
            _buildStepIndicator(size),
            Container(
              width: size.width * 0.23488,
              height: size.width * 0.23488,
              alignment: AlignmentGeometry.center,
              decoration: BoxDecoration(
                color: ThemeApp.Foundation_Main_main_100,
                borderRadius: BorderRadius.circular(78),
              ),
              child: Obx(() {
                log('Loading icon: ${_stepIcon[_currentStep.value]}');
                return SvgPicture.asset(
                  _stepIcon[_currentStep.value],
                  // IconApp.notification,
                  width: 48,
                  height: 48,
                  color: ThemeApp.Foundation_Main_main_500,
                );
              }),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                _stepTitles[_currentStep.value],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: size.width * DimensApp.spaceHorizontalScreen,
            //   ),
            //   child: 
              
              Obx(() => _pages[_currentStep.value]),
            // ),
            const SizedBox(height: 10),

            //  _buildNavigationButtons(),
            Obx(() => _buildNavigationButtons()),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return Obx(
            () => _buildStepCircle(
              index: index,
              isActive: index <= _currentStep.value,
              size: size,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepCircle({
    required int index,
    required bool isActive,
    // required bool isCurrent,
    required Size size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsetsGeometry.symmetric(horizontal: 1),
          width: size.width * 0.2145,
          height: 8.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: isActive
                ? ThemeApp.Foundation_Main_main_500
                : ThemeApp.Foundation_Secendary_grey_100,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // setState(() {
                _currentStep.value--;
                // });
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                side: BorderSide(color: ThemeApp.Foundation_Main_main_500),
              ),
              child: Text(
                'Previous',
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
            ),
          ),

        if (_currentStep > 0) const SizedBox(width: 10),

        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // if (addAdsController.validateStepAddAds(_currentStep)) {
              //   if (_currentStep == 1) {
              //     // if (addAdsController.hasSubCategories) {
              //     categoryController.getSubCategories(
              //       addAdsController.selectedCategoryAds.value!.id,
              //     );
              //     if (categoryController.subCategories.value.isNotEmpty) {
              //       setState(() {
              //         _currentStep = 2;
              //       });
              //     } else {
              //       setState(() {
              //         _currentStep = 3;
              //       });
              //     }
              //   } else {
              // setState(() {
              _currentStep.value++;
              // });
              // }
              // } else {
              //   Get.snackbar(
              //     "Alert",
              //     "This step is required",
              //     backgroundColor: ThemeApp.Foundation_Main_main_50,
              //     colorText: ThemeApp.Foundation_Main_main_500,
              //   );
              // }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              _currentStep == 3 ? 'Submit' : 'Next',
              style: TypographyApp.Body_mid_Mid.copyWith(
                color: ThemeApp.Foundation_Main_main_50,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _publishAd() {
    Get.dialog(
      AlertDialog(
        title: const Text('Published'),
        content: const Text('Your ad has been successfully published'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('OK')),
        ],
      ),
    );
  }
}

// }
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:servixa/core/const/dimens_app.dart';
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';
// import 'package:servixa/features/Business_account/presentation_layer/screens/Second_step_business_account_details_screen.dart';
// import 'package:servixa/features/Business_account/presentation_layer/screens/first_step_select_business_type_screen.dart';
// import 'package:servixa/features/Business_account/presentation_layer/screens/four_step_business_account_document_screen.dart';
// import 'package:servixa/features/Business_account/presentation_layer/screens/third_step_business_account_contact_information_screen.dart';

// class CreateBusinessAccountScreen extends StatefulWidget {
//   CreateBusinessAccountScreen({super.key});

//   @override
//   State<CreateBusinessAccountScreen> createState() =>
//       _CreateBusinessAccountScreenState();
// }

// class _CreateBusinessAccountScreenState
//     extends State<CreateBusinessAccountScreen> {
//   int _currentStep = 0;

//   final List<String> _stepTitles = [
//     "Select a Business Profile Type",
//     "Enter The Business Details",
//     "Enter Contact Information",
//     "Upload Supporting Document",
//   ];

//   final List<String> _stepIcon = [
//     IconApp.businessProfileType,
//     IconApp.businessDetails,
//     IconApp.contactInformation,
//     IconApp.businessProfileType,
//   ];

//   final List<Widget> _pages = [
//     FirstStepSelectBusinessTypeScreen(),
//     SecondStepBusinessAccountDetailsScreen(),
//     ThirdStepBusinessAccountContactInformationScreen(),
//     FourStepBusinessAccountDocumentScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildStepIndicator(size),
//             Container(
//               width: size.width * 0.23488,
//               height: size.width * 0.23488,
//               alignment: AlignmentGeometry.center,
//               decoration: BoxDecoration(
//                 color: ThemeApp.Foundation_Main_main_100,
//                 borderRadius: BorderRadius.circular(78),
//               ),
//               child: SvgPicture.asset(
//                 _stepIcon[_currentStep],
//                 width: 48,
//                 height: 48,
//                 color: ThemeApp.Foundation_Main_main_500,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               _stepTitles[_currentStep],
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.width * DimensApp.spaceHorizontalScreen,
//               ),
//               child: _pages[_currentStep],
//             ),
//             const SizedBox(height: 10),

//             _buildNavigationButtons(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStepIndicator(Size size) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(4, (index) {
//           return _buildStepCircle(
//             index: index,
//             isActive: index <= _currentStep,
//             size: size,
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildStepCircle({
//     required int index,
//     required bool isActive,
//     // required bool isCurrent,
//     required Size size,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           margin: EdgeInsetsGeometry.symmetric(horizontal: 1),
//           width: size.width * 0.2145,
//           height: 8.5,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7),
//             color: isActive
//                 ? ThemeApp.Foundation_Main_main_500
//                 : ThemeApp.Foundation_Secendary_grey_100,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNavigationButtons() {
//     return Row(
//       children: [
//         if (_currentStep > 0)
//           Expanded(
//             child: OutlinedButton(
//               onPressed: () {
//                 setState(() {
//                   _currentStep--;
//                 });
//               },
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 side: BorderSide(color: ThemeApp.Foundation_Main_main_500),
//               ),
//               child: Text(
//                 'Previous',
//                 style: TypographyApp.Body_mid_Mid.copyWith(
//                   color: ThemeApp.Foundation_Main_main_500,
//                 ),
//               ),
//             ),
//           ),

//         if (_currentStep > 0) const SizedBox(width: 10),

//         // زر التالي/نشر
//         Expanded(
//           child: ElevatedButton(
//             onPressed: () {
//               // if (addAdsController.validateStepAddAds(_currentStep)) {
//               //   // التحقق من وجود فروع عند الخطوة الثانية
//               //   if (_currentStep == 1) {
//               //     // الخطوة الثانية (Select the Sub Category)
//               //     // if (addAdsController.hasSubCategories) {
//               //     categoryController.getSubCategories(
//               //       addAdsController.selectedCategoryAds.value!.id,
//               //     );
//               //     if (categoryController.subCategories.value.isNotEmpty) {
//               //       // إذا في فروع → انتقل للخطوة الثالثة
//               //       setState(() {
//               //         _currentStep = 2;
//               //       });
//               //     } else {
//               //       // إذا مافي فروع → انتقل للخطوة الرابعة
//               //       setState(() {
//               //         _currentStep = 3; // تخطي خطوة اختيار الفرع
//               //       });
//               //     }
//               //   } else {
//               //     // باقي الخطوات تتصرف طبيعي
//               setState(() {
//                 _currentStep++;
//               });
//               // }
//               // } else {
//               //   Get.snackbar(
//               //     "Alert",
//               //     "This step is required",
//               //     backgroundColor: ThemeApp.Foundation_Main_main_50,
//               //     colorText: ThemeApp.Foundation_Main_main_500,
//               //   );
//               // }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ThemeApp.Foundation_Main_main_500,
//               padding: const EdgeInsets.symmetric(vertical: 15),
//             ),
//             child: Text(
//               _currentStep == 3 ? 'Submit' : 'Next',
//               style: TypographyApp.Body_mid_Mid.copyWith(
//                 color: ThemeApp.Foundation_Main_main_50,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _publishAd() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Published'),
//         content: const Text('Your ad has been successfully published'),
//         actions: [
//           TextButton(onPressed: () => Get.back(), child: const Text('OK')),
//         ],
//       ),
//     );
//   }
// }
