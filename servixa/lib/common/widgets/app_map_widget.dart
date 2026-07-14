import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/common/widgets/pick_location_screen.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
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
        height: 248,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: -1,
              color: Color.fromRGBO(12, 12, 13, 0.05),
            ),
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: -1,
              color: Color.fromRGBO(12, 12, 13, 0.1),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: SizedBox(
                height: 160,
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
                            position: position.value!,
                          ),
                        },
                      ),
              ),
            ),
            const SizedBox(height: 19),
            SizedBox(
              width: size.width * 0.8465,
              child: OutlinedButton(
                onPressed: () => Get.to(
                  () => PickLocationScreen(
                    onLocationSelected: onLocationSelected,
                    position: position,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 15),
                  side: BorderSide(color: ThemeApp.Foundation_Main_main_500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text("View Location".tr(), style: TypographyApp.Body_mid_Mid),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
