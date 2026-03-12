// import 'package:flutter/material.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';
// import 'package:get/get.dart';
//   void  BottomSheetReviewWidget() {
//     return Get.bottomSheet(
//       // استخدام Container لتخصيص الشكل
//       Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // مهم عشان يأخذ الحجم المناسب
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ✅ الصف الأول: العنوان + زر الإغلاق
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'تقييم المنتج',
//                     style: TypographyApp.Title_larg_Mid.copyWith(
//                       color: ThemeApp.Foundation_Main_Color_900,
//                     ),
//                   ),
//                   // زر الإغلاق
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                       child: const Icon(
//                         Icons.close,
//                         size: 20,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ✅ النجوم للتقييم
//               Center(
//                 child: RatingBar.builder(
//                   initialRating: 3,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 35,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   itemBuilder: (context, _) =>
//                       const Icon(Icons.star, color: Colors.amber),
//                   onRatingUpdate: (rating) {
//                     print('التقييم: $rating');
//                     // هنا تقدر تحفظ التقييم في متغير
//                   },
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ✅ حقل الكتابة الكبير (لتعليق)
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: TextField(
//                   maxLines: 5, // 5 أسطر عشان يكون كبير
//                   minLines: 3, // أقل عدد أسطر
//                   decoration: InputDecoration(
//                     hintText: 'اكتب تعليقك هنا...',
//                     hintStyle: TextStyle(color: Colors.grey[400]),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.all(12),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ✅ صف الأزرار (Send و Cancel)
//               Row(
//                 children: [
//                   // زر Send (يمين - أزرق)
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // منطق إرسال التقييم
//                         print('تم إرسال التقييم');
//                         Get.back(); // إغلاق الـ BottomSheet بعد الإرسال
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ThemeApp.Foundation_Main_main_500,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'إرسال',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 10),

//                   // زر Cancel (يسار - رمادي)
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Get.back(),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[200],
//                         foregroundColor: Colors.black87,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'إلغاء',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // مسافة صغيرة في النهاية
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//       // خيارات إضافية
//       isDismissible: true, // يمكن إغلاقه بالسحب للأسفل
//       enableDrag: true, // يسمح بالسحب للإغلاق
//       backgroundColor: Colors.transparent, // شفاف عشان نشوف الـ Container
//     );

// }

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';

// void BottomSheetReviewWidget() {
//   Get.bottomSheet(
//     // استخدام Container لتخصيص الشكل
//     Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // مهم عشان يأخذ الحجم المناسب
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ✅ الصف الأول: العنوان + زر الإغلاق
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'تقييم المنتج',
//                   style: TypographyApp.Title_larg_Mid.copyWith(
//                     color: ThemeApp.Foundation_Main_Color_900,
//                   ),
//                 ),
//                 // زر الإغلاق
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.grey.withOpacity(0.1),
//                     ),
//                     child: const Icon(
//                       Icons.close,
//                       size: 20,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // ✅ النجوم للتقييم
//             Center(
//               child: RatingBar.builder(
//                 initialRating: 3,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemSize: 35,
//                 itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 itemBuilder: (context, _) =>
//                     const Icon(Icons.star, color: Colors.amber),
//                 onRatingUpdate: (rating) {
//                   print('التقييم: $rating');
//                   // هنا تقدر تحفظ التقييم في متغير
//                 },
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ✅ حقل الكتابة الكبير (لتعليق)
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: TextField(
//                 maxLines: 5, // 5 أسطر عشان يكون كبير
//                 minLines: 3, // أقل عدد أسطر
//                 decoration: InputDecoration(
//                   hintText: 'اكتب تعليقك هنا...',
//                   hintStyle: TextStyle(color: Colors.grey[400]),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.all(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ✅ صف الأزرار (Send و Cancel)
//             Row(
//               children: [
//                 // زر Send (يمين - أزرق)
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // منطق إرسال التقييم
//                       print('تم إرسال التقييم');
//                       Get.back(); // إغلاق الـ BottomSheet بعد الإرسال
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ThemeApp.Foundation_Main_main_500,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       'إرسال',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 // زر Cancel (يسار - رمادي)
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => Get.back(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black87,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       'إلغاء',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // مسافة صغيرة في النهاية
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     ),
//     // خيارات إضافية
//     isDismissible: true, // يمكن إغلاقه بالسحب للأسفل
//     enableDrag: true, // يسمح بالسحب للإغلاق
//     backgroundColor: Colors.transparent, // شفاف عشان نشوف الـ Container
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/auth/presentation_layer/widgets/auth_text_form_field_widget.dart';

class BottomSheetReviewWidget extends StatelessWidget {
  const BottomSheetReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(22),
      decoration: BoxDecoration(
        color: ThemeApp.whiteBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SvgPicture.asset(IconApp.reviewsRounded),
                flex: 1,
              ),
              Expanded(child: Text("Rate this Ad"), flex: 8),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(IconApp.cancel),
                ),
                flex: 1,
              ),
            ],
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),

          AuthTextFormField(
            hintText: "Share your Thought...",
            icon: IconApp.comment,
            minLines: 5,

            // maxLines: 5,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
