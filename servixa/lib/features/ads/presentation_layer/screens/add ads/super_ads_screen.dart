import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';

class SuperAdsScreen extends StatefulWidget {
  SuperAdsScreen({super.key});

  @override
  State<SuperAdsScreen> createState() => _SuperAdsScreenState();
}

class _SuperAdsScreenState extends State<SuperAdsScreen> {
  int _currentStep = 0;

  List<String> _stepTitles = [
    "Select the Main Category",
    "Select the Sub Category",
    "Write Your Ad Details",
    "Write Your Ad Details",
    "Add The Location",
  ];

  List<String> _stepIcon = [
    IconApp.category,
    IconApp.Bedrooms,
    IconApp.Status,
    IconApp.mynauiGrid,
    IconApp.camera,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      appBar: AppBarWidget(),
      body: Column(
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

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child:
          Text(
            _stepTitles[_currentStep],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // ),
          _buildStepContent(),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return _buildStepCircle(
            index: index,
            isActive:
                index <= _currentStep, // الدائرة الحالية والتي قبلها ملونة
            isCurrent: index == _currentStep, // هل هي الخطوة الحالية
            size: size,
          );
        }),
      ),
    );
  }

  Widget _buildStepCircle({
    required int index,
    required bool isActive,
    required bool isCurrent,
    required Size size,
  }) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // الدائرة
        Container(
          margin: EdgeInsetsGeometry.symmetric(horizontal: 2),
          width: size.width * 0.2145,
          height: 8.5,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(7),
            color: isActive
                ? ThemeApp
                      .Foundation_Main_main_500 // ملونة
                : Colors.grey[300], // غير ملونة
            // border: isCurrent
            //     ? Border.all(color: ThemeApp.Foundation_Main_main_500, width: 3)
            //     : null,
          ),
          // child: Center(
          //   child: isActive
          //       ? const Icon(Icons.check, color: Colors.white, size: 20)
          //       : Text(
          //           '${index + 1}',
          //           style: const TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          // ),
        ),

        // // خط بين الدوائر (ما عدا آخر دائرة)
        // if (index < 4)
        //   Container(
        //     width: 30,
        //     height: 2,
        //     color: index < _currentStep
        //         ? ThemeApp
        //               .Foundation_Main_main_500 // الخط ملون
        //         : Colors.grey[300], // الخط رمادي
        //   ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // زر الرجوع (يظهر من الخطوة 1 إلى 4)
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
                child: const Text('السابق'),
              ),
            ),

          if (_currentStep > 0) const SizedBox(width: 10),

          // زر التالي/نشر
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 4) {
                  // انتقال للخطوة التالية
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  // نشر الإعلان
                  _publishAd();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeApp.Foundation_Main_main_500,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(_currentStep == 4 ? 'نشر الإعلان' : 'التالي'),
            ),
          ),
        ],
      ),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _Step1BasicDetails();
      case 1:
        return _Step2Images();
      case 2:
        return _Step3Location();
      case 3:
        return _Step4Price();
      case 4:
        return _Step5Review();
      default:
        return Container();
    }
  }

  // كل خطوة في ويدجت منفصل (أسهل للصيانة)
  Widget _Step1BasicDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'عنوان الإعلان',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'وصف الإعلان',
              border: OutlineInputBorder(),
            ),
          ),
          // ... باقي الحقول
        ],
      ),
    );
  }

  Widget _Step2Images() {
    return Center(child: Text('خطوة إضافة الصور'));
  }

  Widget _Step3Location() {
    return Center(child: Text('خطوة تحديد الموقع'));
  }

  Widget _Step4Price() {
    return Center(child: Text('خطوة تحديد السعر'));
  }

  Widget _Step5Review() {
    return Center(child: Text('خطوة مراجعة الإعلان'));
  }
}
