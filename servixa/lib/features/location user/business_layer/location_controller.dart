import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocationController extends GetxController {
  final storage = FlutterSecureStorage();

  RxString selectedAddress = "".obs;
  Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxString addressUserSelected = "".obs;

  GoogleMapController? mapController;
  final Set<Marker> markers = {};

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
    loadSavedLocation();
  }

  Future<void> _requestPermissions() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            "Permission Denied",
            "Please enable location permission",
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Permission Permanently Denied",
          "Please enable location permission from settings",
        );
        return;
      }

      await getCurrentLocation();
    } catch (e) {
      log("Error requesting permissions: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Permission Denied", "Cannot get your location");
          isLoading.value = false;
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latLng = LatLng(position.latitude, position.longitude);
      currentPosition.value = latLng;
      selectedLatLng.value = latLng;

      mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));

      _addMarker(latLng);

      await _getAddressFromLatLng(latLng);

      log("Current location: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      log("Error getting current location: $e");
      // Get.snackbar("Error", "Could not get your location");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePosition(LatLng position) async {
    selectedLatLng.value = position;
    _addMarker(position);
    await _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = [
          place.street,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((part) => part != null && part.isNotEmpty).join(', ');

        selectedAddress.value = address;
        log("Address: $address");
      } else {
        selectedAddress.value = "Selected location";
      }
    } catch (e) {
      log("Error getting address: $e");
      selectedAddress.value = "Selected location";
    }
  }

  void _addMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("selected_location"),
        position: position,
        infoWindow: const InfoWindow(title: "Your Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  Future<void> saveUserLocation(
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    if (selectedLatLng.value == null) {
      onError("Please select your location");
      return;
    }

    try {
      isSaving.value = true;

      await storage.write(
        key: "user_location",
        value:
            "${selectedLatLng.value!.latitude},${selectedLatLng.value!.longitude}",
      );

      await storage.write(key: "user_address", value: selectedAddress.value);
      addressUserSelected.value = await storage.read(key: "user_address") ?? "";
      addressUserSelected.refresh();
      log("Location saved: ${selectedAddress.value}");
      onSuccess();
    } catch (e) {
      log("Error saving location: $e");
      onError(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> hasUserLocation() async {
    final location = await storage.read(key: "user_location");
    return location != null && location.isNotEmpty;
  }

  Future<void> loadSavedLocation() async {
    try {
      final savedAddress = await storage.read(key: "user_address");
      if (savedAddress != null && savedAddress.isNotEmpty) {
        addressUserSelected.value = savedAddress;
        log("Loaded saved location: $savedAddress");

        final savedLocation = await storage.read(key: "user_location");
        if (savedLocation != null && savedLocation.isNotEmpty) {
          final parts = savedLocation.split(',');
          if (parts.length == 2) {
            final lat = double.tryParse(parts[0]);
            final lng = double.tryParse(parts[1]);
            if (lat != null && lng != null) {
              selectedLatLng.value = LatLng(lat, lng);
              log("Loaded saved coordinates: $lat, $lng");
            }
          }
        }
      }
    } catch (e) {
      log("Error loading saved location: $e");
    }
  }

  void cleanLocationVariables() {
    selectedAddress.value = "";
    selectedLatLng.value = null;
    currentPosition.value = null;
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }
}
