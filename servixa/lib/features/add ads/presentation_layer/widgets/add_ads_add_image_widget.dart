// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/services/image_service.dart';
// import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';

// class AddAdsAddImageWidget extends StatelessWidget {
//   AddAdsController addAdsController = Get.put(AddAdsController());
//   RxList<File> list;
//   String buttonContain;

//   AddAdsAddImageWidget({
//     super.key,
//     required this.list,
//     required this.buttonContain,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Row(
//         children: [
//           if (list.isNotEmpty)
//             Expanded(
//               flex: 2,
//               child: SizedBox(
//                 height: 95,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: list.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.symmetric(horizontal: 6.7),
//                       child: Stack(
//                         // alignment: AlignmentGeometry.topLeft,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.26511,
//                             height: 95,
//                             decoration: BoxDecoration(
//                               // shape: BoxShape.rectangle,
//                               borderRadius: BorderRadius.circular(16),
//                               image: DecorationImage(
//                                 image: FileImage(list[index]),
//                                 fit: BoxFit.cover,
//                               ),
//                               border: Border.all(
//                                 color: ThemeApp.Foundation_Main_main_500,
//                                 width: 2,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 5.3,
//                                   offset: Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // GestureDetector(
//                           //   onTap: () {
//                           //     // setState(() {
//                           //     addAdsController.removeImageAt(list, index);
//                           //     // });
//                           //   },
//                           //   child:
//                           //   Container(
//                           //     width: 20,
//                           //     height: 20,
//                           //     decoration: BoxDecoration(
//                           //       color: Colors.red,
//                           //       shape: BoxShape.circle,
//                           //       // border: Border.all(
//                           //       //   color: Colors.white,
//                           //       //   width: 2,
//                           //       // ),
//                           //     ),
//                           //     child: Icon(
//                           //       Icons.close,
//                           //       size: 14,
//                           //       color: Colors.white,
//                           //     ),
//                           //   ),
//                           // ),
//                           Positioned(
//                             top: -10,
//                             left: -10,
//                             // right: 0,
//                             child: IconButton(
//                               onPressed: () {
//                                 addAdsController.removeImageAt(list, index);
//                               },
//                               icon: SvgPicture.asset(
//                                 IconApp.cancel,
//                                 width: 20,
//                                 height: 20,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),

//           Expanded(
//             flex: 1,
//             child: AppOutlinedButtonWidget(
//               textContent: buttonContain,
//               icon: IconApp.camera,
//               isRow: list.isEmpty,
//               onPressed: () {
//                 // addAdsController.pickImage(list);
//                 // addAdsController.pickMultipleSubImages(list);
//                 ImageService.pickMultipleSubImages(addAdsController.listSelectedSubImage);
//                 // ImageService.pickMultipleSubImages(list);
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/services/image_service.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';

class AddAdsAddImageWidget extends StatelessWidget {
  final AddAdsController addAdsController =
      Get.find<
        AddAdsController
      >(); // استخدام Find أفضل من Put هنا إذا كان منشأ مسبقاً
  final RxList<File> list; // هذه للصور المحلية الجديدة
  final String buttonContain;

  AddAdsAddImageWidget({
    super.key,
    required this.list,
    required this.buttonContain,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // جلب قائمة روابط الصور القادمة من السيرفر من الـ controller
      final networkImages = addAdsController.existingSubImagesUrls;

      // إجمالي عدد الصور الكلي (الشبكة + المحلية)
      final int networkCount = networkImages.length;
      final int localCount = list.length;
      final int totalCount = networkCount + localCount;

      return Row(
        children: [
          if (totalCount > 0)
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 95,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalCount,
                  itemBuilder: (context, index) {
                    final bool isNetworkImage = index < networkCount;

                    // تحديد مصدر الصورة بناءً على الـ index
                    ImageProvider imageProvider;
                    if (isNetworkImage) {
                      imageProvider = NetworkImage(networkImages[index]);
                    } else {
                      final localIndex = index - networkCount;
                      imageProvider = FileImage(list[localIndex]);
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6.7),
                      child: Stack(
                        clipBehavior: Clip
                            .none, // لتجنب قص زر الحذف إذا خرج قليلاً عن الحدود
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.26511,
                            height: 95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: isNetworkImage
                                    ? Colors
                                          .grey
                                          .shade400 // لون مميز للصور القديمة
                                    : ThemeApp
                                          .Foundation_Main_main_500, // لون مميز للصور المضافة حديثاً
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.3,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),

                          // زر الحذف الذكي
                          Positioned(
                            top: -10,
                            left: -10,
                            child: IconButton(
                              onPressed: () {
                                if (isNetworkImage) {
                                  // حذف الصورة من قائمة السيرفر
                                  addAdsController.removeExistingSubImageAt(
                                    index,
                                  );
                                } else {
                                  // حذف الصورة من القائمة المحلية المضافة حديثاً
                                  final localIndex = index - networkCount;
                                  addAdsController.removeImageAt(
                                    list,
                                    localIndex,
                                  );
                                }
                              },
                              icon: SvgPicture.asset(
                                IconApp.cancel,
                                width: 20,
                                height: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          Expanded(
            flex: 1,
            child: AppOutlinedButtonWidget(
              textContent: buttonContain,
              icon: IconApp.camera,
              isRow: totalCount == 0,
              onPressed: () {
                ImageService.pickMultipleSubImages(
                  addAdsController.listSelectedSubImage,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
