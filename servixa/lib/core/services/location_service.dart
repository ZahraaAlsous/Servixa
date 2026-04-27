// // lib/core/services/location_service.dart
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationService {
//   // التحقق من صلاحيات الموقع
//   static Future<bool> checkLocationPermission() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return false;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return false;
//     }

//     return true;
//   }

//   // الحصول على الموقع الحالي
//   static Future<Position> getCurrentLocation() async {
//     bool hasPermission = await checkLocationPermission();
//     if (!hasPermission) {
//       throw Exception("لا توجد صلاحيات للوصول إلى الموقع");
//     }

//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   }

//   // تحويل الإحداثيات إلى اسم مدينة ومنطقة
//   static Future<String> getAddressFromLatLng(Position position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];

//         // بناء النص: مدينة - منطقة
//         String city = place.locality ?? place.subAdministrativeArea ?? '';
//         String area = place.subLocality ?? place.thoroughfare ?? '';

//         if (city.isNotEmpty && area.isNotEmpty) {
//           return "$city - $area";
//         } else if (city.isNotEmpty) {
//           return city;
//         } else if (area.isNotEmpty) {
//           return area;
//         }

//         return "موقعك الحالي";
//       }
//       return "موقع غير معروف";
//     } catch (e) {
//       print("Error getting address: $e");
//       return "خطأ في تحديد الموقع";
//     }
//   }

//   // دالة متكاملة: الحصول على الموقع وتحويله لنص
//   static Future<String> getCurrentLocationName() async {
//     try {
//       Position position = await getCurrentLocation();
//       String address = await getAddressFromLatLng(position);
//       return address;
//     } catch (e) {
//       print("Error: $e");
//       rethrow;
//     }
//   }
// }
