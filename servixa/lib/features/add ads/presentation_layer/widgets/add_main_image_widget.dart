// add_main_image_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/services/image_service.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';

class AddMainImageWidget extends StatelessWidget {
  final String title;

  const AddMainImageWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddAdsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        const SizedBox(height: 8),

        Obx(() {
          if (controller.selectedMainImage.value == null) {
            return _buildEmptyState(controller);
          }

          return _buildImageState(controller);
        }),
      ],
    );
  }

  Widget _buildEmptyState(AddAdsController controller) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate,
            size: 50,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            "Tap to select main image",
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            // onPressed: () => controller.pickMainImage(),
            onPressed: () => ImageService.pickImage(controller.selectedMainImage),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:  Text("Add Main Picture", style: TypographyApp.Body_mid_Mid.copyWith(
                color: ThemeApp.Foundation_Main_main_50,
              ),),
          ),
        ],
      ),
    );
  }

  Widget _buildImageState(AddAdsController controller) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            controller.selectedMainImage.value!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              // onPressed: () => controller.pickMainImage(),
              onPressed: () => ImageService.pickImage(controller.selectedMainImage),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            decoration: const BoxDecoration(
              color: ThemeApp.Foundation_Statue_Red,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white, size: 20),
              onPressed: () => controller.removeMainImage(),
            ),
          ),
        ),
      ],
    );
  }
}
