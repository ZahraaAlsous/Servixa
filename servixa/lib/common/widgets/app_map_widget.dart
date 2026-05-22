import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/common/widgets/pick_location_screen.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

class AppMapWidget extends StatelessWidget {
  final BusinessAccountController controller = Get.put(
    BusinessAccountController(),
  );
  final Rx<LatLng?> position;
  final Function(LatLng) onLocationSelected;
  AppMapWidget({
    super.key,
    required this.position,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        child: Column(
          children: [
            Container(
              height: 234,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              // child: controller.selectedLatLng.value == null
              child: position.value == null
                  ? Center(child: Text("No location selected".tr()))
                  : GoogleMap(
                      mapToolbarEnabled: false,
                      initialCameraPosition: CameraPosition(
                        // target: controller.selectedLatLng.value!,
                        target: position.value!,
                        zoom: 15,
                      ),
                      liteModeEnabled: true,
                      markers: {
                        Marker(
                          markerId: MarkerId("pos"),
                          // position: controller.selectedLatLng.value!,
                          position: position.value!,
                        ),
                      },
                    ),
            ),
            SizedBox(
              width: size.width * 0.8465,
              child: OutlinedButton(
                onPressed: () => Get.to(
                  () => PickLocationScreen(
                    onLocationSelected: onLocationSelected,
                    position: position,
                  ),
                ),
                // edit
                // cntaint
                // translate
                child: Text("View/Change Location"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
