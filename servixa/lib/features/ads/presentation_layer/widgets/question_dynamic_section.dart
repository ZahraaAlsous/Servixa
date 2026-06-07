// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:servixa/core/const/dimens_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';
// import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

// // class QuestionDynamicSection extends StatelessWidget {
// //   final AdsModel ads;
// //   QuestionDynamicSection({super.key, required this.ads});

// //   @override
// //   Widget build(BuildContext context) {
// //     final widthScreen = Get.width;

// //     return Padding(
// //       padding: EdgeInsetsGeometry.symmetric(
// //         horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
// //         vertical: 5,
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "About this item".tr(),
// //             style: TypographyApp.Title_larg_Mid.copyWith(
// //               color: ThemeApp.Foundation_Main_Color_900,
// //             ),
// //           ),
// //           const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

// //           // Wrap(
// //           //   spacing: 10,
// //           //   runSpacing: 12,
// //           //   children: ads.categoryQuestionAnswer!.map((answer) {
// //           //     if (answer.value == null) return const SizedBox();

// //           //     String displayValue = "";
// //           //     if (answer.value is List) {
// //           //       List listValue = answer.value as List;
// //           //       displayValue = listValue.join(", ");
// //           //     } else if (answer.value is String) {
// //           //       if (answer.value.toString().isEmpty) return const SizedBox();
// //           //       displayValue = answer.value;
// //           //     } else {
// //           //       displayValue = answer.value.toString();
// //           //     }

// //           //     return
// //           //     // SizedBox(
// //           //     //   width: widthScreen * 0.45,
// //           //     //   child:
// //           //       Wrap(
// //           //         crossAxisAlignment: WrapCrossAlignment.center,
// //           //         spacing: 4,
// //           //         runSpacing: 2,
// //           //         children: [
// //           //           Text(
// //           //             "${answer.question.question}: ",
// //           //             style: TypographyApp.Title_Mid_Regular.copyWith(
// //           //               color: ThemeApp.black,
// //           //             ),
// //           //           ),
// //           //           Text(
// //           //             displayValue,
// //           //             style: TypographyApp.Title_Mid_Regular.copyWith(
// //           //               color: ThemeApp.Foundation_Main_main_500,
// //           //             ),
// //           //           ),
// //           //           if (answer.unit_of_masure != null &&
// //           //               answer.unit_of_masure!.isNotEmpty)
// //           //             Text(
// //           //               " (${answer.unit_of_masure!})",
// //           //               style: TypographyApp.Title_Mid_Regular.copyWith(
// //           //                 color: ThemeApp.Foundation_Secendary_grey_400,
// //           //               ),
// //           //             ),
// //           //         ],
// //           //       // ),
// //           //     );
// //           //   }).toList(),
// //           // ),
// //           GridView.builder(
// //             shrinkWrap: true,
// //             padding: EdgeInsets.zero,
// //             physics: const NeverScrollableScrollPhysics(),
// //             itemCount: ads.categoryQuestionAnswer!.length,
// //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //               // mainAxisSpacing: 8,
// //               // crossAxisSpacing: 8,
// //               childAspectRatio: 2,
// //             ),
// //             itemBuilder: (context, index) {
// //               return
// //               // Container(
// //               //   padding: const EdgeInsets.all(8),
// //               //   child:
// //               Wrap(
// //                 crossAxisAlignment: WrapCrossAlignment.center,
// //                 spacing: 4,
// //                 runSpacing: 2,
// //                 children: [
// //                   Text(
// //                     "${ads.categoryQuestionAnswer![index].question.question}: ",
// //                     style: TypographyApp.Title_Mid_Regular.copyWith(
// //                       color: ThemeApp.black,
// //                     ),
// //                   ),
// //                   Text(
// //                     ads.categoryQuestionAnswer![index].value.toString(),
// //                     style: TypographyApp.Title_Mid_Regular.copyWith(
// //                       color: ThemeApp.Foundation_Main_main_500,
// //                     ),
// //                   ),
// //                   if (ads.categoryQuestionAnswer![index].unit_of_masure !=
// //                           null &&
// //                       ads
// //                           .categoryQuestionAnswer![index]
// //                           .unit_of_masure!
// //                           .isNotEmpty)
// //                     Text(
// //                       " (${ads.categoryQuestionAnswer![index].unit_of_masure!})",
// //                       style: TypographyApp.Title_Mid_Regular.copyWith(
// //                         color: ThemeApp.Foundation_Secendary_grey_400,
// //                       ),
// //                     ),
// //                 ],
// //                 // ),
// //               );
// //             },
// //           ),
// //           const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
// //         ],
// //       ),
// //     );
// //   }
// // }
// class QuestionDynamicSection extends StatelessWidget {
//   final AdsModel ads;
//   QuestionDynamicSection({super.key, required this.ads});

//   @override
//   Widget build(BuildContext context) {
//     final widthScreen = Get.width;

//     return Padding(
//       padding: EdgeInsetsGeometry.symmetric(
//         horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
//         vertical: 5,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "About this item".tr(),
//             style: TypographyApp.Title_larg_Mid.copyWith(
//               color: ThemeApp.Foundation_Main_Color_900,
//             ),
//           ),
//           const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

//           LayoutBuilder(
//             builder: (context, constraints) {
//               return Wrap(
//                 spacing: 10,
//                 runSpacing: 1,
//                 children: ads.categoryQuestionAnswer!.map((answer) {
//                   if (answer.value == null) return const SizedBox();

//                   String displayValue = "";
//                   if (answer.value is List) {
//                     List listValue = answer.value as List;
//                     displayValue = listValue.join(", ");
//                   } else if (answer.value is String) {
//                     if (answer.value.toString().isEmpty)
//                       return const SizedBox();
//                     displayValue = answer.value;
//                   } else {
//                     displayValue = answer.value.toString();
//                   }

//                   return Wrap(
//                     spacing: 1,
//                     runSpacing: 1,
//                     children: [
//                       // السؤال
//                       Text(
//                         answer.question.question,
//                         style: TypographyApp.Title_Mid_Regular.copyWith(
//                           color: ThemeApp.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       // الجواب
//                       Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         spacing: 4,
//                         children: [
//                           Text(
//                             displayValue,
//                             style: TypographyApp.Title_Mid_Regular.copyWith(
//                               color: ThemeApp.Foundation_Main_main_500,
//                             ),
//                             softWrap: true,
//                           ),
//                           if (answer.unit_of_masure != null &&
//                               answer.unit_of_masure!.isNotEmpty)
//                             Text(
//                               "(${answer.unit_of_masure!})",
//                               style:
//                                   TypographyApp.Title_Mid_Regular.copyWith(
//                                     color: ThemeApp
//                                         .Foundation_Secendary_grey_400,
//                                   ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//           const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
//         ],
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class QuestionDynamicSection extends StatelessWidget {
  final AdsModel ads;
  QuestionDynamicSection({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    final widthScreen = Get.width;

    final validAnswers = ads.categoryQuestionAnswer!.where((answer) {
      if (answer.value == null) return false;
      if (answer.value is String && answer.value.toString().isEmpty)
        return false;
      return true;
    }).toList();

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this item".tr(),
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Main_Color_900,
            ),
          ),
          const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

          Wrap(
            spacing: 10,
            runSpacing:
                14,
            children: validAnswers.map((answer) {
              String displayValue = "";
              if (answer.value is List) {
                List listValue = answer.value as List;
                displayValue = listValue.join(", ");
              } else {
                displayValue = answer.value.toString();
              }

              return SizedBox(
                width:
                    (widthScreen -
                        (widthScreen * DimensApp.spaceHorizontalScreen * 2) -
                        16) /
                    2,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${answer.question.question}: ",
                        style: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.black,
                        ),
                      ),
                      TextSpan(
                        text: displayValue,
                        style: TypographyApp.Title_Mid_Regular.copyWith(
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                      ),
                      if (answer.unit_of_masure != null &&
                          answer.unit_of_masure!.isNotEmpty)
                        TextSpan(
                          text: " (${answer.unit_of_masure!})",
                          style: TypographyApp.Title_Mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_400,
                          ),
                        ),
                    ],
                  ),
                  softWrap:
                      true,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),
        ],
      ),
    );
  }
}
