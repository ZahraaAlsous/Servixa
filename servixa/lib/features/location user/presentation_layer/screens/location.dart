import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/location%20user/business_layer/location_controller.dart';
import 'package:servixa/features/home/presentation_layer/screens/super_home_screen.dart';

class LocationPickerScreen extends StatelessWidget {
  // final LocationController locationController = Get.put(LocationController());
  // final LocationController locationController =
  //     Get.isRegistered<LocationController>()
  //     ? Get.find<LocationController>()
  //     : Get.put(LocationController(), permanent: true);
  final LocationController locationController = Get.find<LocationController>();

  LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SvgPicture.asset(
                    IconApp.location,
                    width: 80,
                    height: 80,
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Select Your Location".tr(),
                    style: TypographyApp.Title_larg_Mid.copyWith(
                      color: ThemeApp.Foundation_Main_main_500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please select your location to get better services".tr(),
                    style: TypographyApp.Body_mid_Regular.copyWith(
                      color: ThemeApp.Foundation_Secendary_grey_400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ThemeApp.Foundation_Secendary_grey_300,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Obx(() {
                        if (locationController.isLoading.value) {
                          return LoadingAnimationWidget(
                            message: "Getting your location...".tr(),
                          );
                          //  const Center(
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       CircularProgressIndicator(),
                          //       SizedBox(height: 16),
                          //       Text("Getting your location..."),
                          //     ],
                          //   ),
                          // );
                        }
                        return GoogleMap(
                          onMapCreated: (controller) {
                            locationController.mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target:
                                locationController.currentPosition.value ??
                                const LatLng(33.5138, 36.2765),
                            zoom: 14,
                          ),
                          onTap: (latLng) {
                            locationController.updatePosition(latLng);
                          },
                          markers: locationController.markers,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeApp.Foundation_Main_main_50,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.my_location,
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                        onPressed: () {
                          // locationController.getCurrentLocationAndSelect();
                          locationController.getCurrentLocation();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (locationController.selectedAddress.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    locationController.selectedAddress.value,
                    style: const TextStyle(color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                if (locationController.isSaving.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: locationController.selectedLatLng.value == null
                        ? null
                        : () {
                            locationController.saveUserLocation(
                              () {
                                Get.offAll(() => const SuperHomeScreen());
                              },
                              (error) {
                                Get.snackbar("Error", error);
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.Foundation_Main_main_500,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: Text(
                      // locationController.selectedAddress.value.isEmpty
                      //     ? "Select Location on Map"
                      //     :
                      "Confirm Location".tr(),
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_yellow_50,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
