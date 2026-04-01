import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/first_step_business_account_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/five_step_add_location_page.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/four_step_write_ad_details_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/second_step_select_category_widget.dart';
import 'package:servixa/features/add%20ads/presentation_layer/screens/third_step_sup_category_widget.dart';
import 'package:servixa/features/category/business_later/category_controller.dart';

class SuperAdsScreen extends StatefulWidget {
  SuperAdsScreen({super.key});

  @override
  State<SuperAdsScreen> createState() => _SuperAdsScreenState();
}

class _SuperAdsScreenState extends State<SuperAdsScreen> {
  AdsController adsController = Get.put(AdsController());
  AddAdsController addAdsController = Get.put(AddAdsController());
  CategoryController categoryController = Get.put(CategoryController());
  int _currentStep = 0;

  List<String> _stepTitles = [
    "Select your business account",
    "Select the Main Category",
    "Select the Sub Category",
    "Write Your Ad Details",
    "Add The Location",
  ];

  List<String> _stepIcon = [
    IconApp.business,
    IconApp.category,
    IconApp.SubCategory,
    IconApp.searchPaper,
    IconApp.SubCategory,
  ];
  List<Widget> _pages = [
    FirstStepBusinessAccountWidget(),
    SecondStepSelectCategoryWidget(),
    ThirdStepSupCategoryWidget(),
    FourStepWriteAdDetailsWidget(),
    FiveStepAddLocationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
        ),
        child: Column(
          children: [
            _buildStepIndicator(size),
            Container(
              width: size.width * 0.23488,
              height: size.width * 0.23488,
              alignment: AlignmentGeometry.center,
              decoration: BoxDecoration(
                color: ThemeApp.Foundation_Main_main_100,
                borderRadius: BorderRadius.circular(26),
              ),
              // edit
              // يمكن صورة من الباك
              child: SvgPicture.asset(
                _stepIcon[_currentStep],
                width: 48,
                height: 48,
                color: ThemeApp.Foundation_Main_main_500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _stepTitles[_currentStep],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _pages[_currentStep],
            const SizedBox(height: 10),

            _buildNavigationButtons(),
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
        children: List.generate(5, (index) {
          return _buildStepCircle(
            index: index,
            isActive: index <= _currentStep,
            size: size,
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
          width: size.width * 0.179,
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
                setState(() {
                  _currentStep--;
                });
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

        // زر التالي/نشر
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (addAdsController.validateStepAddAds(_currentStep)) {
                // التحقق من وجود فروع عند الخطوة الثانية
                if (_currentStep == 1) {
                  // الخطوة الثانية (Select the Sub Category)
                  // if (addAdsController.hasSubCategories) {
                  categoryController.getSubCategories(
                    addAdsController.selectedCategoryAds.value!.id,
                  );
                  if (categoryController.subCategories.value.isNotEmpty) {
                    // إذا في فروع → انتقل للخطوة الثالثة
                    setState(() {
                      _currentStep = 2;
                    });
                  } else {
                    // إذا مافي فروع → انتقل للخطوة الرابعة
                    setState(() {
                      _currentStep = 3; // تخطي خطوة اختيار الفرع
                    });
                  }
                } else {
                  // باقي الخطوات تتصرف طبيعي
                  setState(() {
                    _currentStep++;
                  });
                }
              } else {
                Get.snackbar(
                  "Alert",
                  "This step is required",
                  backgroundColor: ThemeApp.Foundation_Main_main_50,
                  colorText: ThemeApp.Foundation_Main_main_500,
                );
              }
            },

            // onPressed: () {
            //   if (_currentStep < 4) {
            //     // انتقال للخطوة التالية
            //     if (_currentStep == 2) {
            //       categoryController.getSubCategories(
            //         addAdsController.selectedCategoryAds.value!.id,
            //       );
            //     }
            //     setState(() {
            //       // addAdsController.validateStepAddAds(_currentStep);
            //       // ? (_currentStep == 1 &&
            //       //           categoryController.subCategories.value != null
            //       //       ?
            //       // _currentStep++
            //       //       : _currentStep += 2)
            //       // : Get.snackbar("title", "message");

            //       addAdsController.validateStepAddAds(_currentStep)
            //           ? _currentStep++
            //           : Get.snackbar("title", "This step is important");
            //     });
            //   } else {
            //     // نشر الإعلان
            //     _publishAd();
            //   }
            // },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              _currentStep == 4 ? 'Submit' : 'Next',
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
    // منطق نشر الإعلان
    Get.dialog(
      AlertDialog(
        title: const Text('تم النشر'),
        content: const Text('تم نشر إعلانك بنجاح'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('حسناً')),
        ],
      ),
    );
  }

  // Widget _buildStepContent() {
  //   switch (_currentStep) {
  //     case 0:
  //       return FirstStepBusinessAccountWidget();
  //     case 1:
  //       return SecondStepSelectCategoryWidget();
  //     case 2:
  //       return ThirdStepSupCategoryWidget();
  //     case 3:
  //       return FourStepWriteAdDetailsWidget();
  //     case 4:
  //       return FiveStepAddLocationPage();
  //     default:
  //       return Container();
  //   }
  // }
}
