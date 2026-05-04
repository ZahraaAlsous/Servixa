// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

// // class PickLocationScreen extends StatelessWidget {
// //   final BusiessAccountController businessAccountController = Get.find();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Pick Location")),
// //       body: GoogleMap(
// //         initialCameraPosition: CameraPosition(
// //           target:
// //               businessAccountController.selectedLatLng.value ??
// //               LatLng(33.5138, 36.2765),
// //           zoom: 15,
// //         ),
// //         onTap: (LatLng latLng) {
// //           businessAccountController.updatePosition(latLng);
// //           Get.back();
// //         },
// //         markers: businessAccountController.selectedLatLng.value != null
// //             ? {
// //                 Marker(
// //                   markerId: MarkerId("selected"),
// //                   position: businessAccountController.selectedLatLng.value!,
// //                 ),
// //               }
// //             : {},
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart'; // تأكد من استيرادها
// import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

// class PickLocationScreen extends StatefulWidget {
//   @override
//   State<PickLocationScreen> createState() => _PickLocationScreenState();
// }

// class _PickLocationScreenState extends State<PickLocationScreen> {
//   final BusiessAccountController businessAccountController = Get.find();
//   final TextEditingController searchController = TextEditingController();
//   GoogleMapController? mapController;

//   // دالة البحث عن مكان
//   Future<void> searchPlace() async {
//     try {
//       if (searchController.text.isEmpty) return;

//       List<Location> locations = await locationFromAddress(
//         searchController.text,
//       );

//       if (locations.isNotEmpty) {
//         Location place = locations.first;
//         LatLng newPos = LatLng(place.latitude, place.longitude);

//         // تحريك الكاميرا للموقع الجديد
//         mapController?.animateCamera(CameraUpdate.newLatLngZoom(newPos, 15));

//         // تحديث الموقع في الكنترولر
//         businessAccountController.updatePosition(newPos);
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Location not found",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pick Location")),
//       body: Stack(
//         children: [
//           // 1. الخريطة
//           Obx(
//             () => GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target:
//                     businessAccountController.selectedLatLng.value ??
//                     const LatLng(33.5138, 36.2765),
//                 zoom: 15,
//               ),
//               onMapCreated: (controller) => mapController = controller,
//               onTap: (LatLng latLng) {
//                 businessAccountController.updatePosition(latLng);
//               },
//               markers: businessAccountController.selectedLatLng.value != null
//                   ? {
//                       Marker(
//                         markerId: const MarkerId("selected"),
//                         position:
//                             businessAccountController.selectedLatLng.value!,
//                       ),
//                     }
//                   : {},
//             ),
//           ),

//           // 2. شريط البحث (فوق الخريطة)
//           Positioned(
//             top: 10,
//             left: 15,
//             right: 15,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(color: Colors.black26, blurRadius: 5),
//                 ],
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: "Search for a place...",
//                   border: InputBorder.none,
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: searchPlace,
//                   ),
//                 ),
//                 onSubmitted: (_) =>
//                     searchPlace(), // البحث عند الضغط على زر "تم" في الكيبورد
//               ),
//             ),
//           ),

//           // 3. زر التأكيد (اختياري)
//           Positioned(
//             bottom: 20,
//             left: 50,
//             right: 50,
//             child: ElevatedButton(
//               onPressed: () => Get.back(),
//               child: const Text("Confirm Location"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // مكتبة الموقع
import 'package:servixa/core/services/location_service.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';

// class PickLocationScreen extends StatefulWidget {
//   @override
//   State<PickLocationScreen> createState() => _PickLocationScreenState();
// }

// class _PickLocationScreenState extends State<PickLocationScreen> {
//   final BusiessAccountController businessAccountController = Get.find();
//   final TextEditingController searchController = TextEditingController();
//   GoogleMapController? mapController;

//   // دالة لجلب الموقع الحالي للمستخدم
//   // Future<void> getCurrentLocation() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;

//   //   // التأكد من تفعيل خدمة الموقع
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     Get.snackbar("Error", "Location services are disabled.");
//   //     return;
//   //   }

//   //   // طلب صلاحيات الموقع
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       Get.snackbar("Error", "Location permissions are denied.");
//   //       return;
//   //     }
//   //   }

//   //   // جلب الإحداثيات الحالية
//   //   Position position = await Geolocator.getCurrentPosition();
//   //   LatLng currentLatLng = LatLng(position.latitude, position.longitude);

//   //   // تحريك الكاميرا وتحديث البيانات
//   //   mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
//   //   businessAccountController.updatePosition(currentLatLng);
//   // }

//   Future<void> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

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
//       businessAccountController.updatePosition(currentLatLng);
//     } catch (e) {
//       Get.snackbar("Error", "Could not fetch location. Try again.");
//     }
//   }

//   Future<void> searchPlace() async {
//     try {
//       if (searchController.text.isEmpty) return;
//       List<Location> locations = await locationFromAddress(
//         searchController.text,
//       );
//       if (locations.isNotEmpty) {
//         Location place = locations.first;
//         LatLng newPos = LatLng(place.latitude, place.longitude);
//         mapController?.animateCamera(CameraUpdate.newLatLngZoom(newPos, 15));
//         businessAccountController.updatePosition(newPos);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Location not found");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pick Location")),
//       // زر جلب الموقع الحالي
//       floatingActionButton: FloatingActionButton(
//         onPressed: getCurrentLocation,
//         backgroundColor: Colors.white,
//         child: const Icon(Icons.my_location, color: Colors.blue),
//       ),
//       body: Stack(
//         children: [
//           Obx(
//             () => GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target:
//                     businessAccountController.selectedLatLng.value ??
//                     const LatLng(33.5138, 36.2765),
//                 zoom: 15,
//               ),
//               onMapCreated: (controller) => mapController = controller,
//               mapToolbarEnabled: false, // إخفاء زر جوجل ماب هنا أيضاً
//               myLocationEnabled: true, // يظهر نقطة زرقاء مكان المستخدم
//               myLocationButtonEnabled:
//                   false, // نخفيه لأننا صنعنا زر مخصص (FloatingActionButton)
//               onTap: (LatLng latLng) {
//                 businessAccountController.updatePosition(latLng);
//               },
//               markers: businessAccountController.selectedLatLng.value != null
//                   ? {
//                       Marker(
//                         markerId: const MarkerId("selected"),
//                         position:
//                             businessAccountController.selectedLatLng.value!,
//                       ),
//                     }
//                   : {},
//             ),
//           ),

//           // شريط البحث
//           Positioned(
//             top: 10,
//             left: 15,
//             right: 15,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(color: Colors.black26, blurRadius: 5),
//                 ],
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: "Search (e.g. Damascus, Mazzeh)",
//                   border: InputBorder.none,
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: searchPlace,
//                   ),
//                 ),
//                 onSubmitted: (_) => searchPlace(),
//               ),
//             ),
//           ),

//           // زر التأكيد
//           Positioned(
//             bottom: 20,
//             left: 80,
//             right: 80,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               onPressed: () => Get.back(),
//               child: const Text(
//                 "Confirm Location",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class PickLocationScreen extends StatefulWidget {
  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final BusiessAccountController businessAccountController = Get.find();
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;

  // تحريك الكاميرا (دالة داخلية للـ UI)
  void _moveCamera(LatLng pos) {
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(pos, 15));
    businessAccountController.updatePosition(pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.my_location, color: Colors.blue),
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
                    businessAccountController.selectedLatLng.value ??
                    const LatLng(33.5138, 36.2765),
                zoom: 15,
              ),
              onMapCreated: (controller) => mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onTap: (LatLng latLng) =>
                  businessAccountController.updatePosition(latLng),
              markers: businessAccountController.selectedLatLng.value != null
                  ? {
                      Marker(
                        markerId: const MarkerId("selected"),
                        position:
                            businessAccountController.selectedLatLng.value!,
                      ),
                    }
                  : {},
            ),
          ),

          // شريط البحث
          Positioned(top: 10, left: 15, right: 15, child: _buildSearchBar()),

          // زر التأكيد
          Positioned(
            bottom: 20,
            left: 80,
            right: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () => Get.back(),
              child: const Text(
                "Confirm Location",
                style: TextStyle(color: Colors.white),
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
          hintText: "Search (e.g. Damascus)",
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
