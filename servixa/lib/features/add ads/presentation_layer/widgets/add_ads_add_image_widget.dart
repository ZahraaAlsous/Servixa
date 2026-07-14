import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/services/image_service.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/ads/business_later/ads_controller.dart';

class AddAdsAddImageWidget extends StatelessWidget {
  final AddAdsController addAdsController = Get.find<AddAdsController>();
  final AdsController adsController = Get.put(AdsController());
  final RxList<File> list;
  final String buttonContain;

  AddAdsAddImageWidget({
    super.key,
    required this.list,
    required this.buttonContain,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // final networkImages = addAdsController.existingSubImagesUrls;
      final networkImages = addAdsController.existingSubImages;

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

                    ImageProvider imageProvider;
                    if (isNetworkImage) {
                      imageProvider = NetworkImage(networkImages[index].url);
                    } else {
                      final localIndex = index - networkCount;
                      imageProvider = FileImage(list[localIndex]);
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6.7),
                      child: Stack(
                        clipBehavior: Clip.none,
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
                                    ? Colors.grey.shade400
                                    : ThemeApp.Foundation_Main_main_500,
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

                          Positioned(
                            top: -5,
                            left: -5,
                            child: Obx(() {
                              if (index >= networkImages.length) {
                                return IconButton(
                                  onPressed: () {
                                    final localIndex = index - networkCount;
                                    addAdsController.removeImageAt(
                                      list,
                                      localIndex,
                                    );
                                    // }
                                  },
                                  icon: SvgPicture.asset(
                                    IconApp.cancel,
                                    width: 20,
                                    height: 20,
                                    color: Colors.red,
                                  ),
                                );
                              }

                              final imageId = networkImages[index].id;
                              final isLoading =
                                  addAdsController.isDeleteImageNaw[imageId] ==
                                  true;

                              if (isLoading) {
                                return const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return IconButton(
                                onPressed: () {
                                  if (isNetworkImage) {
                                    // addAdsController.removeExistingSubImageAt(
                                    //   index,
                                    // );

                                    addAdsController.deleteImage(
                                      adId: adsController.adsDetails.value!.id,
                                      imageId: networkImages[index].id,
                                      localIndex: index,
                                    );
                                  }
                                  // else {
                                  //   final localIndex = index - networkCount;
                                  //   addAdsController.removeImageAt(
                                  //     list,
                                  //     localIndex,
                                  //   );
                                  // }
                                },
                                icon: SvgPicture.asset(
                                  IconApp.cancel,
                                  width: 20,
                                  height: 20,
                                  color: Colors.red,
                                ),
                              );
                            }),
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
