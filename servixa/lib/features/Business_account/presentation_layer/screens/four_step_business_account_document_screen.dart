import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/dd.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';


class FourStepBusinessAccountDocumentScreen extends StatelessWidget {
  BusiessAccountController busiessAccountController = Get.put(
    BusiessAccountController(),
  );
  AddAdsController addAdsController = Get.put(AddAdsController());
  FourStepBusinessAccountDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Supporting Documents",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        Obx(
          () => ListView.builder(
            itemCount: busiessAccountController.listFile.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, indexFile) {
              File file = busiessAccountController.listFile[indexFile];
              String fileName = file.path.split('/').last;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: size.width * 0.9139,
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: ThemeApp.Foundation_Secendary_grey_100,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    fileName.endsWith('.pdf')
                        ? Icons.picture_as_pdf
                        : Icons.description,
                    color: fileName.endsWith('.pdf') ? Colors.red : Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    fileName,
                    style: TypographyApp.Body_mid_Regular.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Max Size ${(file.lengthSync() / (1024 * 1024)).toStringAsFixed(2)} MB",
                    style: TypographyApp.Label_Mid_Mid.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_300,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      busiessAccountController.openFile(file.path);
                    },
                    child: Text(
                      "View",
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                  ),

                  // IconButton(
                  //   icon: const Icon(Icons.delete_outline, color: Colors.red),
                  //   onPressed: () {
                  //     busiessAccountController.deleteFile(indexFile);
                  //   },
                  // ),
                ),
              );
            },
          ),
        ),
        AppOutlinedButtonWidget(
          textContent: "Upload Doc",
          paddingVertical: 5,
          onPressed: () {
            busiessAccountController.pickFile();
            // () async {
            //   try {
            //     FilePickerResult? result = await FilePicker.platform.pickFiles(
            //       allowMultiple: true,
            //       type: FileType.custom,
            //       allowedExtensions: ['pdf', 'doc'],
            //     );
            //     if (result != null) {
            //       List<File> files = result.paths
            //           .map((path) => File(path!))
            //           .toList();
            //     }
            //   } catch (e) {
            //     log("error: $e");
            //   }
          },
          icon: IconApp.pdf,
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
        ElevatedButton(onPressed: (){
          Get.to(CurrentLocationPage());
        }, child: Text("jj"))
      ],
    );
  }
}
