import 'dart:developer';
import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';

class FourStepBusinessAccountDocumentScreen extends StatelessWidget {
  BusiessAccountController busiessAccountController = Get.put(
    BusiessAccountController(),
  );
  AddAdsController addAdsController = Get.put(AddAdsController());
  FourStepBusinessAccountDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ElevatedButton(onPressed: (){

        // }, child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SvgPicture.asset(IconApp.notification),
        //     Text("  Upload Doc")
        //   ],
        // )),
        ElevatedButton(
          onPressed:
              ()
              {
              // () async {
              //   try {
              //     var result = await FilePicker.platform.pickFiles();
              //     if (result != null) {
              //       log("success: ${result.files.first.path}");
              //     }
              //   } catch (e) {
              //     log("error: $e");
              //   }
              },
          child: Text("Test File Picker"),
        ),

        AppOutlinedButtonWidget(
          textContent: "Upload Doc",
          paddingVertical: 5,
          onPressed: () {
            // async {
            // busiessAccountController.pickFile();
            // addAdsController.pickImage(busiessAccountController.listFile);
            log("click");
            // final result = await FilePicker.platform.pickFiles();
            // if (result == null) return;
            // final File file = File(result.files.single.path!);
            // Future.microtask(() async {
            //   try {
            //     final result = await FilePicker.platform.pickFiles();
            //     if (result == null) return;
            //     final File file = File(result.files.single.path!);
            //   } catch (e) {
            //     log("error + $e");
            //   }
            // });
          },
          icon: IconApp.favorite,
        ),
        Obx(() {
          if (busiessAccountController.listImage.isNotEmpty) {
            return SizedBox(
              height: 95,
              child:
                  // Obx(
                  //   () =>
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: busiessAccountController.listImage.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.7),
                        child: Stack(
                          // alignment: AlignmentGeometry.topLeft,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.26511,
                              height: 95,
                              decoration: BoxDecoration(
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: FileImage(
                                    busiessAccountController.listImage[index],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: ThemeApp.Foundation_Main_main_500,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.3,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),

                            // GestureDetector(
                            //   onTap: () {
                            //     // setState(() {
                            //     addAdsController.removeImageAt(list, index);
                            //     // });
                            //   },
                            //   child:
                            //   Container(
                            //     width: 20,
                            //     height: 20,
                            //     decoration: BoxDecoration(
                            //       color: Colors.red,
                            //       shape: BoxShape.circle,
                            //       // border: Border.all(
                            //       //   color: Colors.white,
                            //       //   width: 2,
                            //       // ),
                            //     ),
                            //     child: Icon(
                            //       Icons.close,
                            //       size: 14,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              top: -10,
                              left: -10,
                              // right: 0,
                              child: IconButton(
                                onPressed: () {
                                  addAdsController.removeImageAt(
                                    busiessAccountController.listImage,
                                    index,
                                  );
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
              // ),
            );
          } else {
            return SizedBox();
          }
        }),

        AppOutlinedButtonWidget(
          textContent: "Upload Image",
          onPressed: () {
            addAdsController.pickImage(busiessAccountController.listImage);
          },
          icon: IconApp.camera,
        ),
      ],
    );
  }
}
