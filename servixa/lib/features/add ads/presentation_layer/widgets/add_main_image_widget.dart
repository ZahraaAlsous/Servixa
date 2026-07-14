import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
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
          title.tr(),
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        const SizedBox(height: 8),

        Obx(() {
          if (controller.selectedMainImage.value != null) {
            return _buildLocalImageState(controller);
          }

          if (controller.existingMainImageUrl.isNotEmpty) {
            return _buildNetworkImageState(controller);
          }

          return _buildEmptyState(controller);
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
            "Tap to select main image".tr(),
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () =>
                ImageService.pickImage(controller.selectedMainImage),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeApp.Foundation_Main_main_500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Add Main Picture".tr(),
              style: TypographyApp.Body_mid_Mid.copyWith(
                color: ThemeApp.Foundation_Main_main_50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkImageState(AddAdsController controller) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            controller.existingMainImageUrl.value,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                color: Colors.grey.shade100,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
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
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ), 
              onPressed: () =>
                  ImageService.pickImage(controller.selectedMainImage),
            ),
          ),
        ),      
      ],
    );
  }

  Widget _buildLocalImageState(AddAdsController controller) {
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
              onPressed: () =>
                  ImageService.pickImage(controller.selectedMainImage),
            ),
          ),
        ),
      ],
    );
  }
}
