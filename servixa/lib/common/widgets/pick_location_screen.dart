import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/services/location_service.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
class PickLocationScreen extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  final Rx<LatLng?> position;
  const PickLocationScreen({
    super.key,
    required this.onLocationSelected,
    required this.position,
  });

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final BusinessAccountController businessAccountController = Get.find();
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;

  void _moveCamera(LatLng pos) {
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(pos, 15));
    // businessAccountController.updatePosition(pos);
    widget.onLocationSelected(pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Pick Location")),
      appBar: AppBarWidget(title: Text("Pick Location")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeApp.whiteBackground,
        child: const Icon(Icons.my_location, color: ThemeApp.Foundation_Main_main_500),
        onPressed: () async {
          LatLng? pos = await LocationService.getCurrentLatLng();
          if (pos != null) _moveCamera(pos);
        },
      ),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    // businessAccountController.selectedLatLng.value ??
                    widget.position.value ?? const LatLng(33.5138, 36.2765),
                zoom: 15,
              ),
              onMapCreated: (controller) => mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onTap: (LatLng latLng) =>
                  // businessAccountController.updatePosition(latLng),
                  widget.onLocationSelected(latLng),
              // markers: businessAccountController.selectedLatLng.value != null
              markers: widget.position.value != null
                  ? {
                      Marker(
                        markerId: const MarkerId("selected"),
                        position:
                            // businessAccountController.selectedLatLng.value!,
                            widget.position.value!,
                      ),
                    }
                  : {},
            ),
          ),

          Positioned(top: 10, left: 15, right: 15, child: _buildSearchBar()),

          Positioned(
            bottom: 20,
            left: 80,
            right: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: ThemeApp.whiteBackground),
              onPressed: () => Get.back(),
              child: const Text(
                "Confirm Location",
                style: TextStyle(color: ThemeApp.Foundation_Main_main_500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchAction,
          ),
        ),
        onSubmitted: (_) => _onSearchAction(),
      ),
    );
  }

  void _onSearchAction() async {
    LatLng? pos = await LocationService.getLatLngFromAddress(
      searchController.text,
    );
    if (pos != null) {
      _moveCamera(pos);
    } else {
      Get.snackbar("Error", "Location not found");
    }
  }
}
