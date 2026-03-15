// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/image_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';
// import 'package:servixa/features/ads/business_later/ads_controller.dart';
// import 'package:servixa/features/ads/presentation_layer/widgets/outlined_button_widget.dart';
// import 'package:servixa/features/auth/presentation_layer/widgets/auth_text_form_field_widget.dart';
// import 'package:image_picker/image_picker.dart';

// class FourStepWriteAdDetailsWidget extends StatefulWidget {
//   FourStepWriteAdDetailsWidget({super.key});

//   @override
//   State<FourStepWriteAdDetailsWidget> createState() => _FourStepWriteAdDetailsWidgetState();
// }

// class _FourStepWriteAdDetailsWidgetState extends State<FourStepWriteAdDetailsWidget> {
//   AdsController adsController = Get.put(AdsController());
//             File? selectedImage; // 👈 لتخزين الصورة المختارة

//   @override
//   Widget build(BuildContext context) {
//     return

//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Ad Title",
//           style: TypographyApp.Title_Mid_Mid.copyWith(
//             color: ThemeApp.Foundation_Secendary_grey_600,
//           ),
//         ),
//         AuthTextFormField(hintText: "Title..", icon: IconApp.tags),
//         Text(
//           "Ad Slug",
//           style: TypographyApp.Title_Mid_Mid.copyWith(
//             color: ThemeApp.Foundation_Secendary_grey_600,
//           ),
//         ),
//         AuthTextFormField(hintText: "Slug..", icon: IconApp.solarLinkOutline),
//         Text(
//           "Description",
//           style: TypographyApp.Title_Mid_Mid.copyWith(
//             color: ThemeApp.Foundation_Secendary_grey_600,
//           ),
//         ),
//         AuthTextFormField(
//           hintText: "Description..",
//           icon: IconApp.description,
//           minLines: 3,
//         ),
//         OutlinedButtonWidget(
//           textContent: "Add Main Picture",
//           onPressed: () {
//             // _pickImage();
//           },
//         ),

//         // ✅ استخدم Obx لتحديث الصورة تلقائياً
//         // Obx(() {
//         //   return CircleAvatar(
//         //     radius: 60,
//         //     backgroundColor: ThemeApp.Foundation_Secendary_grey_100,
//         //     backgroundImage: adsController.selectedImage.value != null
//         //         ? FileImage(adsController.selectedImage.value!)
//         //         :  AssetImage(ImageApp.profileImageRounded)
//         //               as ImageProvider,
//         //     child: adsController.selectedImage.value == null
//         //         ? Icon(
//         //             Icons.add_a_photo,
//         //             size: 30,
//         //             color: ThemeApp.Foundation_Main_main_500,
//         //           )
//         //         : null,
//         //   );
//         // }),

//                         Stack(
//           children: [
//             CircleAvatar(
//               radius: 60,
//               backgroundImage: selectedImage != null
//                   ? FileImage(selectedImage!) // 👈 صورة مختارة
//                   : AssetImage(ImageApp.profileImageRounded),
//               // child: user.img!.isEmpty && selectedImage == null
//               //     ? const Icon(Icons.person, size: 60)
//               //     : null,
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: CircleAvatar(
//                 radius: 18,
//                 backgroundColor: const Color.fromARGB(255, 102, 102, 102),
//                 child: IconButton(
//                   icon: Icon(Icons.camera_alt, size: 15, color: Colors.white),
//                   onPressed: _pickImage,
//                 ),
//               ),
//             ),
//           ],
//         ),

//       ],
//     );
//   }
// Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         selectedImage = File(pickedFile.path);
//       });
//     }
//   }
//   // Future<void> _pickImage() async {
//   //   final picker = ImagePicker();
//   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   //   if (pickedFile != null) {
//   //     adsController.selectedImage.value = File(pickedFile.path);
//   //   }
//   // }
// }
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_checkbox_terms_policies_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:image_picker/image_picker.dart';

class FourStepWriteAdDetailsWidget extends StatefulWidget {
  FourStepWriteAdDetailsWidget({super.key});

  @override
  State<FourStepWriteAdDetailsWidget> createState() =>
      _FourStepWriteAdDetailsWidgetState();
}

class _FourStepWriteAdDetailsWidgetState
    extends State<FourStepWriteAdDetailsWidget> {
  AdsController adsController = Get.put(AdsController());
  List<File> listSelectedImage = [];
  // File? selectedImage; // 👈 لتخزين الصورة المختارة

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ad Title",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextFormField(hintText: "Title..", icon: IconApp.tags),

        const SizedBox(height: 16), // ✅ أضف مسافات بين الحقول

        Text(
          "Ad Slug",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextFormField(hintText: "Slug..", icon: IconApp.solarLinkOutline),

        const SizedBox(height: 16),

        Text(
          "Description",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        AppTextFormField(
          hintText: "Description..",
          icon: IconApp.description,
          minLines: 3,
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            if (listSelectedImage.isNotEmpty)
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 95,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: listSelectedImage.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Stack(
                          children: [
                            // ✅ الصورة
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(listSelectedImage[index]),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: ThemeApp.Foundation_Main_main_500,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              top: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    listSelectedImage.removeAt(index);
                                  });
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
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
                textContent: "Add Main Picture",
                isRow: listSelectedImage.isEmpty,
                onPressed: () {
                  _pickImage();
                },
              ),
            ),
          ],
        ),
        Text(
          "price",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),

        // edit
        // add dropdown
        Text(
          "Type",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),

        // edit
        // add dropdown
        AppCheckboxTermsPoliciesWidget(),
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024, // ✅ أضفها عشان تتحكم بحجم الصورة
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          // selectedImage = File(pickedFile.path);
          listSelectedImage!.add(File(pickedFile.path));
        });
        log('Image selected: ${pickedFile.path}');
      } else {
        log('User cancelled');
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }
}
