// // // lib/core/services/location_service.dart
// // import 'package:geolocator/geolocator.dart';
// // import 'package:geocoding/geocoding.dart';

// // class LocationService {
// //   // التحقق من صلاحيات الموقع
// //   static Future<bool> checkLocationPermission() async {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       return false;
// //     }

// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         return false;
// //       }
// //     }

// //     if (permission == LocationPermission.deniedForever) {
// //       return false;
// //     }

// //     return true;
// //   }

// //   // الحصول على الموقع الحالي
// //   static Future<Position> getCurrentLocation() async {
// //     bool hasPermission = await checkLocationPermission();
// //     if (!hasPermission) {
// //       throw Exception("لا توجد صلاحيات للوصول إلى الموقع");
// //     }

// //     return await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );
// //   }

// //   // تحويل الإحداثيات إلى اسم مدينة ومنطقة
// //   static Future<String> getAddressFromLatLng(Position position) async {
// //     try {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         position.latitude,
// //         position.longitude,
// //       );

// //       if (placemarks.isNotEmpty) {
// //         Placemark place = placemarks[0];

// //         // بناء النص: مدينة - منطقة
// //         String city = place.locality ?? place.subAdministrativeArea ?? '';
// //         String area = place.subLocality ?? place.thoroughfare ?? '';

// //         if (city.isNotEmpty && area.isNotEmpty) {
// //           return "$city - $area";
// //         } else if (city.isNotEmpty) {
// //           return city;
// //         } else if (area.isNotEmpty) {
// //           return area;
// //         }

// //         return "موقعك الحالي";
// //       }
// //       return "موقع غير معروف";
// //     } catch (e) {
// //       print("Error getting address: $e");
// //       return "خطأ في تحديد الموقع";
// //     }
// //   }

// //   // دالة متكاملة: الحصول على الموقع وتحويله لنص
// //   static Future<String> getCurrentLocationName() async {
// //     try {
// //       Position position = await getCurrentLocation();
// //       String address = await getAddressFromLatLng(position);
// //       return address;
// //     } catch (e) {
// //       print("Error: $e");
// //       rethrow;
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

// class LocationService {
//   static Future<void> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     GoogleMapController? mapController;
//     BusiessAccountController businessAccountController = Get.put(
//       BusiessAccountController(),
//     );

//     // 1. التأكد من تفعيل خدمة الموقع في الجهاز
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // هنا تظهر الرسالة التي تسأل المستخدم تفعيل الموقع وفتحه للإعدادات
//       Get.defaultDialog(
//         title: "Location Services Disabled",
//         middleText:
//             "Please enable location services to find your current position.",
//         textConfirm: "Settings",
//         textCancel: "Cancel",
//         confirmTextColor: Colors.white,
//         onConfirm: () async {
//           await Geolocator.openLocationSettings(); // تفتح إعدادات الجهاز للمستخدم
//           Get.back();
//         },
//       );
//       return;
//     }

//     // 2. فحص وطلب صلاحيات التطبيق (Permission)
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Get.snackbar("Error", "Location permissions are denied.");
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // إذا رفض المستخدم الصلاحيات بشكل دائم
//       Get.snackbar(
//         "Permission Error",
//         "Location permissions are permanently denied. Please enable them from app settings.",
//       );
//       await Geolocator.openAppSettings();
//       return;
//     }

//     // 3. جلب الموقع الفعلي بعد التأكد من كل شيء
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       LatLng currentLatLng = LatLng(position.latitude, position.longitude);

//       mapController?.animateCamera(
//         CameraUpdate.newLatLngZoom(currentLatLng, 15),
//       );
//       // edit
//       businessAccountController.updatePosition(currentLatLng);
//     } catch (e) {
//       Get.snackbar("Error", "Could not fetch location. Try again.");
//     }
//   }

//   static Future<void> searchPlace(
//     TextEditingController searchController,
//   ) async {
//     try {
//       GoogleMapController? mapController;
//       final BusiessAccountController businessAccountController = Get.put(
//         BusiessAccountController(),
//       );

//       if (searchController.text.isEmpty) return;
//       List<Location> locations = await locationFromAddress(
//         searchController.text,
//       );
//       if (locations.isNotEmpty) {
//         Location place = locations.first;
//         LatLng newPos = LatLng(place.latitude, place.longitude);
//         mapController?.animateCamera(CameraUpdate.newLatLngZoom(newPos, 15));
//         // edit
//         businessAccountController.updatePosition(newPos);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Location not found");
//     }
//   }
// }

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocationService {
  // دالة التعامل مع الصلاحيات وخدمة الـ GPS
  static Future<bool> checkLocationSettings() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Get.defaultDialog(
        title: "Location Services Disabled",
        middleText: "Please enable location services to find your position.",
        textConfirm: "Settings",
        textCancel: "Cancel",
        confirmTextColor: Colors.white,
        onConfirm: () async {
          await Geolocator.openLocationSettings();
          Get.back();
        },
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    return true;
  }

  // جلب الإحداثيات الحالية
  static Future<LatLng?> getCurrentLatLng() async {
    bool hasPermission = await checkLocationSettings();
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  // البحث عن مكان نصي وتحويله لإحداثيات
  static Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (_) {}
    return null;
  }
}
