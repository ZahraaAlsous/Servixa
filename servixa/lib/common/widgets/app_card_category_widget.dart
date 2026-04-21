import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';

class AppCardCategoryWidget extends StatelessWidget {
  final String? assetName;
  final String categoryName;
  final int CategoryId;
  final bool? margin;
  final void Function()? onTap;
  final TextStyle? typographyApp;
  // final bool enableSelection;
  // final bool isThisCardSelect;

  AddAdsController addAdsController = Get.put(AddAdsController());
  AppCardCategoryWidget({
    super.key,
    required this.assetName,
    required this.categoryName,
    required this.CategoryId,
    this.typographyApp,
    this.margin,
    this.onTap,
    // this.enableSelection = false,
    // this.isThisCardSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: margin == null
            ? EdgeInsetsGeometry.zero
            : EdgeInsetsGeometry.symmetric(
                // edit
                // إذا ضفت padding أو margin للصفحة كاملة  ما يتأثر الطرف الأول من الناصر مع طرف الصفحة
                horizontal: size.width * (DimensApp.gapBetweenCategoryCard / 2),
              ),
        padding: EdgeInsetsGeometry.all(5),
        width: size.width * 0.279,
        height: 100,
        decoration: BoxDecoration(
          color: ThemeApp.Foundation_Main_main_50,
          borderRadius: BorderRadius.circular(41),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // edit
            // لازم بعدين حطها networq
            // لازم حط عرض و طول أو اعمل شي لل صورة؟
            if (assetName != null)
              Image(image: AssetImage(assetName!), width: 34, height: 34),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              // note
              maxLines: 2,
              style:
                  typographyApp ??
                  TypographyApp.Body_mid_Mid.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: ThemeApp.Foundation_Secendary_grey_600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeCardCategoryWidget extends StatelessWidget {
//   final String assetName;
//   final String categoryName;
//   final int CategoryId;
//   final bool? margin;
//   final void Function()? onTap;
//   final TextStyle? typographyApp;
//   final bool enableSelection;
//   final bool isThisCardSelect;

//   // ✅ استخدام Get.find بدل Get.put
//   final AddAdsController addAdsController = Get.find<AddAdsController>();

//   HomeCardCategoryWidget({
//     super.key,
//     required this.assetName,
//     required this.categoryName,
//     required this.CategoryId,
//     this.typographyApp,
//     this.margin,
//     this.onTap,
//     this.enableSelection = false,
//     this.isThisCardSelect = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     // ✅ استخدام Obx لمراقبة التغييرات
//     return Obx(() {
//       bool isSelected =
//           enableSelection &&
//           (isThisCardSelect ||
//               CategoryId == addAdsController.selectedCategoryAds.value?.id);

//       return InkWell(
//         highlightColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         onTap: onTap,
//         child: Container(
//           margin: margin == null
//               ? EdgeInsets.zero
//               : EdgeInsets.symmetric(
//                   horizontal:
//                       size.width * (DimensApp.gapBetweenCategoryCard / 2),
//                 ),
//           padding: const EdgeInsets.all(5),
//           width: size.width * 0.279,
//           height: 100,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.amber : ThemeApp.Foundation_Main_main_50,
//             borderRadius: BorderRadius.circular(41),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image(image: AssetImage(assetName), width: 34, height: 34),
//               const SizedBox(height: 4),
//               Text(
//                 categoryName,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 style:
//                     typographyApp ??
//                     TypographyApp.Body_mid_Mid.copyWith(
//                       overflow: TextOverflow.ellipsis,
//                       color: ThemeApp.Foundation_Secendary_grey_600,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

// class HomeCardCategoryWidget extends StatelessWidget {
//   final String assetName;
//   final String categoryName;
//   final int CategoryId;
//   final bool? margin;
//   final void Function()? onTap;
//   final TextStyle? typographyApp;
//   final bool enableSelection;
//   final bool isThisCardSelect;
//   final int? selectCategoryId;

//   // ✅ استخدام Get.find (وليس Get.put)
//   final AddAdsController addAdsController = Get.find<AddAdsController>();

//   HomeCardCategoryWidget({
//     super.key,
//     required this.assetName,
//     required this.categoryName,
//     required this.CategoryId,
//     this.typographyApp,
//     this.margin,
//     this.onTap,
//     this.enableSelection = false,
//     this.isThisCardSelect = false,
//     this.selectCategoryId
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     // ✅ استخدام Obx فقط إذا كان enableSelection = true
//     if (enableSelection) {
//       return Obx(() => _buildContent(size));
//     } else {
//       return _buildContent(size);
//     }
//   }

//   Widget _buildContent(Size size) {
//     bool isSelected =
//         enableSelection &&
//         (isThisCardSelect ||
//             CategoryId == selectCategoryId );

//     return InkWell(
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       onTap: onTap,
//       child: Container(
//         margin: margin == null
//             ? EdgeInsets.zero
//             : EdgeInsets.symmetric(
//                 horizontal: size.width * (DimensApp.gapBetweenCategoryCard / 2),
//               ),
//         padding: const EdgeInsets.all(5),
//         width: size.width * 0.279,
//         height: 100,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.amber : ThemeApp.Foundation_Main_main_50,
//           borderRadius: BorderRadius.circular(41),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image(image: AssetImage(assetName), width: 34, height: 34),
//             const SizedBox(height: 4),
//             Text(
//               categoryName,
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               style:
//                   typographyApp ??
//                   TypographyApp.Body_mid_Mid.copyWith(
//                     overflow: TextOverflow.ellipsis,
//                     color: ThemeApp.Foundation_Secendary_grey_600,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
