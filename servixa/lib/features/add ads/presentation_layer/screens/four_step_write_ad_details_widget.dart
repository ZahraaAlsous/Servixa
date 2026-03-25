import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/common/widgets/app_checkbox_terms_policies_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_ads_add_image_widget.dart';
import 'package:servixa/common/widgets/app_dropdown_button_form_field_widget.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';

class FourStepWriteAdDetailsWidget extends StatefulWidget {
  FourStepWriteAdDetailsWidget({super.key});

  @override
  State<FourStepWriteAdDetailsWidget> createState() =>
      _FourStepWriteAdDetailsWidgetState();
}

class _FourStepWriteAdDetailsWidgetState
    extends State<FourStepWriteAdDetailsWidget> {
  AdsController adsController = Get.put(AdsController());
  AddAdsController addAdsController = Get.put(AddAdsController());
  // File? selectedImage; // 👈 لتخزين الصورة المختارة
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController slugController = TextEditingController();

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
        const SizedBox(height: 5),

        AppTextFormField(
          hintText: "Title..",
          icon: IconApp.tags,
          controller: titleController,
          validator: Validators.validateReviewAndRequestOrder,
          onChanged: (value) {
            addAdsController.adTitle = value;
          },
        ),

        const SizedBox(height: 16),

        Text(
          "Ad Slug",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        const SizedBox(height: 5),

        AppTextFormField(
          hintText: "Slug..",
          icon: IconApp.solarLinkOutline,
          controller: slugController,
          onChanged: (value) {
            addAdsController.adSlug = value;
          },
          validator: Validators.validateReviewAndRequestOrder,
        ),

        const SizedBox(height: 16),

        Text(
          "Description",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        const SizedBox(height: 5),

        AppTextAreaWidget(
          hintText: "Description..",
          prefixIcon: IconApp.description,
          onChange: (value) {
            addAdsController.adDescription = value;
          },
          controller: descriptionController,
        ),
        const SizedBox(height: 16),

        // Obx(() {
        //   return

        //   Row(
        //     children: [
        //       if (addAdsController.listSelectedImage.isNotEmpty)
        //         Expanded(
        //           flex: 2,
        //           child: SizedBox(
        //             height: 95,
        //             child: ListView.builder(
        //               // shrinkWrap: true,
        //               // physics: NeverScrollableScrollPhysics(),
        //               scrollDirection: Axis.horizontal,
        //               itemCount: addAdsController.listSelectedImage.length,
        //               itemBuilder: (context, index) {
        //                 return Container(
        //                   margin: EdgeInsets.only(right: 12),
        //                   child: Stack(
        //                     children: [
        //                       // ✅ الصورة
        //                       Container(
        //                         width: 100,
        //                         height: 100,
        //                         decoration: BoxDecoration(
        //                           shape: BoxShape.rectangle,
        //                           borderRadius: BorderRadius.circular(12),
        //                           image: DecorationImage(
        //                             image: FileImage(
        //                               addAdsController.listSelectedImage[index],
        //                             ),
        //                             fit: BoxFit.cover,
        //                           ),
        //                           border: Border.all(
        //                             color: ThemeApp.Foundation_Main_main_500,
        //                             width: 2,
        //                           ),
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: Colors.black.withOpacity(0.1),
        //                               blurRadius: 4,
        //                               offset: Offset(0, 2),
        //                             ),
        //                           ],
        //                         ),
        //                       ),

        //                       Positioned(
        //                         top: -5,
        //                         right: -5,
        //                         child: GestureDetector(
        //                           onTap: () {
        //                             // setState(() {
        //                             addAdsController.removeImageAt(index);
        //                             // });
        //                           },
        //                           child: Container(
        //                             width: 24,
        //                             height: 24,
        //                             decoration: BoxDecoration(
        //                               color: Colors.red,
        //                               shape: BoxShape.circle,
        //                               border: Border.all(
        //                                 color: Colors.white,
        //                                 width: 2,
        //                               ),
        //                             ),
        //                             child: Icon(
        //                               Icons.close,
        //                               size: 14,
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               },
        //             ),
        //           ),
        //         ),

        //       Expanded(
        //         flex: 1,
        //         child: AppOutlinedButtonWidget(
        //           textContent: "Add Main Picture",
        //           isRow: addAdsController.listSelectedImage.value.isEmpty,
        //           onPressed: () {
        //             _pickImage();
        //           },
        //         ),
        //       ),
        //     ],
        //   );

        // }),
        // Obx((() {
        //   return AddAdsAddImageWidget(list: addAdsController.listSelectedImage);
        // })),
        AddAdsAddImageWidget(
          list: addAdsController.listSelectedMainImage,
          buttonContain: "Add Main Picture",
        ),
        SizedBox(height: 16),
        AddAdsAddImageWidget(
          list: addAdsController.listSelectedSubImage,
          buttonContain: "Add Sub Picture",
        ),
        Text(
          "price",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        const SizedBox(height: 5),

        AppDropdownButtonFormFieldWidget(
          hintText: "Fixed",
          onChanged: (value) {
            addAdsController.typeCoin = value;
          },
          prefixIcon: IconApp.price,
          borderRadio: 16,
          validator: Validators.validateReviewAndRequestOrder,
          items: [
            DropdownMenuItem<String>(
              value: "dolar",
              child: Text(
                "\$",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
              alignment: Alignment.center,
            ),
            DropdownMenuItem<String>(
              value: "sp",
              child: Text(
                "Sp",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
              alignment: Alignment.center,
            ),
          ],
        ),

        // Obx(
        //   () => DropdownButtonFormField<String?>(
        //     value: addAdsController.selectedCurrency.value,
        //     items: const [
        //       // edit
        //       // from back value
        //       DropdownMenuItem<String?>(value: "1", child: Text("\$")),
        //       DropdownMenuItem<String?>(value: "2", child: Text("sp")),
        //     ],
        //     onChanged: (String? value) {
        //       if (value != null) {
        //         addAdsController.selectedCurrency.value = value;
        //       }
        //     },
        //     decoration: InputDecoration(
        //       contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 100),
        //       enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16),
        //         borderSide: BorderSide(
        //           color: ThemeApp.Foundation_Secendary_grey_100,
        //         ),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16),
        //         borderSide: BorderSide(
        //           color: ThemeApp.Foundation_Secendary_grey_100,
        //         ),
        //       ),
        //       errorBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16),
        //         borderSide: BorderSide(color: Colors.red),
        //       ),
        //       hintStyle: TypographyApp.Body_mid_Regular.copyWith(
        //         color: ThemeApp.Foundation_Secendary_grey_200,
        //       ),
        //       hintText: "Fixed",
        //       prefixIcon: Padding(
        //         padding: const EdgeInsets.all(12),
        //         child: SvgPicture.asset(IconApp.price, width: 24, height: 24),
        //       ),
        //     ),
        //     // hint: const Text("Fixed"),
        //     validator: Validators.validateReviewAndRequestOrder,
        //   ),
        // ),
        Text(
          "Type",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        const SizedBox(height: 5),

        // edit
        // value from back
        // AddAdsDropdownButtonFormFieldWidget(
        //   hintText: "Service Request",
        //   onChanged: (value) {
        //     addAdsController.typeCoin = value;
        //   },
        //   prefixIcon: IconApp.suggestion,
        //   borderRadio: 4,
        //   validator: Validators.validateReviewAndRequestOrder,
        //   items: const [
        //     DropdownMenuItem<String>(
        //       value: "dolar",
        //       child: Text("\$"),
        //       alignment: Alignment.center,
        //     ),
        //     DropdownMenuItem<String>(
        //       value: "sp",
        //       child: Text("Sp"),
        //       alignment: Alignment.center,
        //     ),
        //   ],
        // ),
        AppDropdownButtonFormFieldWidget(
          hintText: "Service Request",
          onChanged: (value) {
            addAdsController.typeService = value;
          },
          prefixIcon: IconApp.suggestion,
          borderRadio: 4,
          validator: Validators.validateReviewAndRequestOrder,
          items: [
            DropdownMenuItem<String>(
              value: "dolar",
              child: Text(
                "Dollar \$",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
              alignment: Alignment.center,
            ),

            DropdownMenuItem<String>(
              value: "sp",
              child: Text(
                "Sp Syrian pounds",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
        if (addAdsController.selectedCategoryAds.value?.questions != null &&
            addAdsController.selectedCategoryAds.value!.questions!.isNotEmpty)
          // Container(
          //   width: 100,
          //   height: 100,
          //   color: Colors.amber,
          // ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                addAdsController.selectedCategoryAds.value!.questions!.length,
            itemBuilder: (context, indexQuestion) {
              CategoryQuestionModel question = addAdsController
                  .selectedCategoryAds
                  .value!
                  .questions![indexQuestion];
              if (question.type == "text") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question.question),
                    AppTextFormField(hintText: question.question),
                  ],
                );
              } else if (question.type == "dropdown") {
                // AddAdsDropdownButtonFormFieldWidget(items: [],)

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question.question),
                    AppDropdownButtonFormFieldWidget(
                      hintText: question.question,
                      // edit
                      onChanged: (value) {},
                      items:
                          question.options?.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(
                                option,
                                style: TypographyApp.Body_mid_Mid.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_400,
                                ),
                              ),
                              alignment: Alignment.center,
                            );
                          }).toList() ??
                          [],
                      prefixIcon: IconApp.Status,
                      borderRadio: 16,
                    ),
                  ],
                );
              } else if (question.type == "checkbox") {
                return Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Text(question.question),
                  ],
                );
              }
            },
          ),

        AppCheckboxTermsPoliciesWidget(),
      ],
    );
  }

  // Future<void> _pickImage() async {
  //   try {
  //     final picker = ImagePicker();
  //     final pickedFile = await picker.pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 1024, // ✅ أضفها عشان تتحكم بحجم الصورة
  //       maxHeight: 1024,
  //       imageQuality: 85,
  //     );

  //     if (pickedFile != null) {
  //       addAdsController.addImage(File(pickedFile.path));
  //       log('Image selected: ${pickedFile.path}');
  //     } else {
  //       log('User cancelled');
  //     }
  //   } catch (e) {
  //     log('Error picking image: $e');
  //   }
  // }
}
