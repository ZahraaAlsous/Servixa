// // lib/test/geocoding_test_screen.dart
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class GeocodingTestScreen extends StatefulWidget {
//   const GeocodingTestScreen({super.key});

//   @override
//   State<GeocodingTestScreen> createState() => _GeocodingTestScreenState();
// }

// class _GeocodingTestScreenState extends State<GeocodingTestScreen> {
//   String _result = "Press button to test";
//   bool _isLoading = false;
  
//   // للإحداثيات اليدوية
//   final TextEditingController _latController = TextEditingController();
//   final TextEditingController _lngController = TextEditingController();
  
//   // للبحث عن مكان
//   final TextEditingController _addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Geocoding Test'),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ✅ قسم 1: تحويل الإحداثيات إلى عنوان
//             const Text(
//               '📍 Convert Coordinates to Address',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
            
//             TextField(
//               controller: _latController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Latitude',
//                 hintText: '33.5138',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
            
//             TextField(
//               controller: _lngController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Longitude',
//                 hintText: '36.2765',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
            
//             ElevatedButton(
//               onPressed: _isLoading ? null : _convertCoordinatesToAddress,
//               child: _isLoading 
//                   ? const CircularProgressIndicator()
//                   : const Text('Convert to Address'),
//             ),
//             const SizedBox(height: 20),
            
//             // ✅ قسم 2: جلب الموقع الحالي
//             const Text(
//               '📍 Get Current Location',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
            
//             ElevatedButton(
//               onPressed: _isLoading ? null : _getCurrentLocation,
//               child: const Text('Get My Current Location'),
//             ),
//             const SizedBox(height: 20),
            
//             // ✅ قسم 3: البحث عن مكان
//             const Text(
//               '🔍 Search Address to Coordinates',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
            
//             TextField(
//               controller: _addressController,
//               decoration: const InputDecoration(
//                 labelText: 'Address',
//                 hintText: 'Riyadh, Saudi Arabia',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
            
//             ElevatedButton(
//               onPressed: _isLoading ? null : _searchAddressToCoordinates,
//               child: const Text('Search Coordinates'),
//             ),
//             const SizedBox(height: 30),
            
//             // ✅ عرض النتيجة
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     '📋 Result:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     _result,
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ✅ دالة 1: تحويل الإحداثيات إلى عنوان
//   Future<void> _convertCoordinatesToAddress() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _result = "Converting...";
//       });

//       // قراءة الإحداثيات
//       double lat = double.parse(_latController.text);
//       double lng = double.parse(_lngController.text);

//       // تحويل الإحداثيات إلى عنوان
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
        
//         _result = '''
// ✅ Success!

// 📍 Coordinates: $lat, $lng
// 🏙️ Country: ${place.country ?? 'N/A'}
// 📍 Administrative Area: ${place.administrativeArea ?? 'N/A'}
// 🏢 Sub-Administrative Area: ${place.subAdministrativeArea ?? 'N/A'}
// 🏙️ Locality: ${place.locality ?? 'N/A'}
// 📍 Sub-Locality: ${place.subLocality ?? 'N/A'}
// 🏠 Thoroughfare: ${place.thoroughfare ?? 'N/A'}
// 📮 Postal Code: ${place.postalCode ?? 'N/A'}
// 📝 Name: ${place.name ?? 'N/A'}

// Full Address: ${place.name ?? ''} ${place.thoroughfare ?? ''} ${place.locality ?? ''} ${place.country ?? ''}
//         ''';
//       } else {
//         _result = "❌ No address found for these coordinates";
//       }
      
//     } catch (e) {
//       _result = "❌ Error: $e\n\nMake sure you entered valid coordinates.\nExample: Lat: 33.5138, Lng: 36.2765";
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // ✅ دالة 2: جلب الموقع الحالي
//   Future<void> _getCurrentLocation() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _result = "Getting location...";
//       });

//       // طلب الصلاحيات
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           _result = "❌ Location permission denied";
//           setState(() => _isLoading = false);
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         _result = "❌ Location permission permanently denied";
//         setState(() => _isLoading = false);
//         return;
//       }

//       // جلب الموقع
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // تحويل إلى عنوان
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
        
//         _result = '''
// ✅ Current Location Found!

// 📍 Coordinates: ${position.latitude}, ${position.longitude}
// 🎯 Accuracy: ${position.accuracy} meters
// 🏙️ Country: ${place.country ?? 'N/A'}
// 📍 Administrative Area: ${place.administrativeArea ?? 'N/A'}
// 🏢 Sub-Administrative Area: ${place.subAdministrativeArea ?? 'N/A'}
// 🏙️ Locality: ${place.locality ?? 'N/A'}
// 📍 Sub-Locality: ${place.subLocality ?? 'N/A'}
// 🏠 Street: ${place.thoroughfare ?? 'N/A'}

// Full Address: ${place.name ?? ''} ${place.thoroughfare ?? ''} ${place.locality ?? ''} ${place.country ?? ''}
//         ''';
//       } else {
//         _result = "📍 Coordinates: ${position.latitude}, ${position.longitude}\nBut no address details available";
//       }
      
//     } catch (e) {
//       _result = "❌ Error: $e\n\nMake sure: \n 1. GPS is enabled on your device \n 2. Location permissions are granted \n 3. You are in an area with good GPS signal";
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // ✅ دالة 3: البحث عن مكان وتحويله لإحداثيات
//   Future<void> _searchAddressToCoordinates() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _result = "Searching...";
//       });

//       String address = _addressController.text;
      
//       if (address.isEmpty) {
//         _result = "❌ Please enter an address to search";
//         setState(() => _isLoading = false);
//         return;
//       }

//       // البحث عن الإحداثيات
//       List<Location> locations = await locationFromAddress(address);
      
//       if (locations.isNotEmpty) {
//         Location location = locations.first;
        
//         _result = '''
// ✅ Address Found!

// 🔍 Searched: "$address"
// 📍 Coordinates: ${location.latitude}, ${location.longitude}
// 🗺️ More details available: ${locations.length} location(s) found

// Tap on the button again to get more detailed results:
//         ''';
        
//         // عرض أول 3 نتائج
//         for (int i = 0; i < (locations.length > 3 ? 3 : locations.length); i++) {
//           _result += '''
        
// ${i + 1}. Lat: ${locations[i].latitude}, Lng: ${locations[i].longitude}
//         ''';
//         }
//       } else {
//         _result = "❌ No coordinates found for: $address\n\nTry a more specific address like:\n- 'Eiffel Tower, Paris'\n- 'Times Square, New York'\n- 'Burj Khalifa, Dubai'";
//       }
      
//     } catch (e) {
//       _result = "❌ Error: $e\n\nMake sure you entered a valid address.\nExample: 'Riyadh, Saudi Arabia' or 'Central Park, New York'";
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _latController.dispose();
//     _lngController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }

// lib/test/geocoding_test_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeocodingTestScreen extends StatefulWidget {
  const GeocodingTestScreen({super.key});

  @override
  State<GeocodingTestScreen> createState() => _GeocodingTestScreenState();
}

class _GeocodingTestScreenState extends State<GeocodingTestScreen> {
  String _result = "Press on the map or use buttons below";
  bool _isLoading = false;

  // للإحداثيات اليدوية
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  // للبحث عن مكان
  final TextEditingController _addressController = TextEditingController();

  // للخريطة
  GoogleMapController? _mapController;
  LatLng _selectedLocation = const LatLng(33.5138, 36.2765); // موقع افتراضي
  final Set<Marker> _markers = {};

  // تحديد وضع الخريطة
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _addMarkerAtPosition(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geocoding Test with Map'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocationOnMap,
            tooltip: 'Go to my location',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🗺️ قسم الخريطة (الجديد)
            Container(
              height: 300,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                    setState(() {
                      _isMapReady = true;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 12,
                  ),
                  onTap: _onMapTap, // ✅ الضغط على الخريطة
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  compassEnabled: true,
                ),
              ),
            ),

            // معلومات الموقع المختار
            if (_selectedLocation != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected Location:",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Lat: ${_selectedLocation.latitude.toStringAsFixed(6)}, Lng: ${_selectedLocation.longitude.toStringAsFixed(6)}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          // نسخ الإحداثيات
                          _copyToClipboard();
                        },
                        tooltip: 'Copy coordinates',
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // ✅ قسم 1: تحويل الإحداثيات إلى عنوان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📍 Convert Coordinates to Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _latController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Latitude',
                            hintText: '33.5138',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _lngController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Longitude',
                            hintText: '36.2765',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : _convertCoordinatesToAddress,
                          icon: const Icon(Icons.gps_fixed),
                          label: const Text('Convert to Address'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // استخدام إحداثيات الموقع المختار
                            _latController.text = _selectedLocation.latitude
                                .toString();
                            _lngController.text = _selectedLocation.longitude
                                .toString();
                            _convertCoordinatesToAddress();
                          },
                          icon: const Icon(Icons.location_on),
                          label: const Text('Use Selected'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ قسم 2: جلب الموقع الحالي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📍 Get Current Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _getCurrentLocation,
                          icon: const Icon(Icons.my_location),
                          label: const Text('Get Location & Address'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _moveToCurrentLocation,
                          icon: const Icon(Icons.map),
                          label: const Text('Move Map to Me'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ قسم 3: البحث عن مكان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔍 Search Address to Coordinates',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Riyadh, Saudi Arabia',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) => _searchAddressToCoordinates(),
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _searchAddressToCoordinates,
                    icon: const Icon(Icons.search),
                    label: const Text('Search Coordinates & Move Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ✅ عرض النتيجة
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(width: 8),
                      Text(
                        'Result:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(_result, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ جديد: دالة الضغط على الخريطة
  void _onMapTap(LatLng position) async {
    setState(() {
      _isLoading = true;
      _selectedLocation = position;
      _result =
          "📍 Getting address for: ${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}...";
    });

    // إضافة علامة (Marker) في المكان المضغوط
    _addMarkerAtPosition(position);

    // تحريك الكاميرا إلى الموقع
    _mapController?.animateCamera(CameraUpdate.newLatLng(position));

    // الحصول على العنوان من الإحداثيات
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        setState(() {
          _result =
              '''
✅ Location Selected!

📍 Coordinates: ${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}

📍 Address Details:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏙️ Country: ${place.country ?? 'N/A'}
📍 Administrative Area: ${place.administrativeArea ?? 'N/A'}
🏢 Sub-Administrative Area: ${place.subAdministrativeArea ?? 'N/A'}
🏙️ City/Locality: ${place.locality ?? 'N/A'}
📍 Sub-Locality: ${place.subLocality ?? 'N/A'}
🏠 Street: ${place.thoroughfare ?? 'N/A'}
📮 Postal Code: ${place.postalCode ?? 'N/A'}
📝 Name: ${place.name ?? 'N/A'}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Full Address: ${place.name ?? ''} ${place.thoroughfare ?? ''} ${place.locality ?? ''} ${place.country ?? ''}
          ''';
        });

        // تحديث حقول الإحداثيات
        _latController.text = position.latitude.toString();
        _lngController.text = position.longitude.toString();
      } else {
        setState(() {
          _result =
              "📍 Location: ${position.latitude}, ${position.longitude}\n⚠️ No address details found for this location";
        });
      }
    } catch (e) {
      setState(() {
        _result =
            "📍 Location: ${position.latitude}, ${position.longitude}\n❌ Error getting address: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ✅ إضافة علامة على الخريطة
  void _addMarkerAtPosition(LatLng position) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId("selected_location"),
        position: position,
        infoWindow: InfoWindow(
          title: "Selected Location",
          snippet:
              "Lat: ${position.latitude.toStringAsFixed(6)}, Lng: ${position.longitude.toStringAsFixed(6)}",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
    setState(() {});
  }

  // ✅ جديد: تحريك الخريطة إلى الموقع الحالي
  Future<void> _moveToCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
        _result = "Getting your current location...";
      });

      // التحقق من الصلاحيات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _result = "❌ Location permission denied";
          setState(() => _isLoading = false);
          return;
        }
      }

      // جلب الموقع
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      // تحريك الخريطة
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 15),
      );

      // إضافة علامة
      _addMarkerAtPosition(currentLocation);

      setState(() {
        _selectedLocation = currentLocation;
        _result =
            "✅ Moved map to your location!\n📍 Coordinates: ${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}";
        _latController.text = position.latitude.toString();
        _lngController.text = position.longitude.toString();
      });
    } catch (e) {
      setState(() {
        _result = "❌ Error getting location: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ✅ جديد: نسخ الإحداثيات
  void _copyToClipboard() {
    // يمكن إضافة Clipboard package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Copied: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}",
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ✅ دالة 1: تحويل الإحداثيات إلى عنوان
  Future<void> _convertCoordinatesToAddress() async {
    try {
      setState(() {
        _isLoading = true;
        _result = "Converting...";
      });

      double lat = double.parse(_latController.text);
      double lng = double.parse(_lngController.text);

      // تحريك الخريطة للإحداثيات
      LatLng newLocation = LatLng(lat, lng);
      _addMarkerAtPosition(newLocation);
      _mapController?.animateCamera(CameraUpdate.newLatLng(newLocation));
      setState(() {
        _selectedLocation = newLocation;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _result =
            '''
✅ Success!

📍 Coordinates: $lat, $lng
🏙️ Country: ${place.country ?? 'N/A'}
📍 Administrative Area: ${place.administrativeArea ?? 'N/A'}
🏢 Sub-Administrative Area: ${place.subAdministrativeArea ?? 'N/A'}
🏙️ Locality: ${place.locality ?? 'N/A'}
📍 Sub-Locality: ${place.subLocality ?? 'N/A'}
🏠 Thoroughfare: ${place.thoroughfare ?? 'N/A'}
📮 Postal Code: ${place.postalCode ?? 'N/A'}
📝 Name: ${place.name ?? 'N/A'}

Full Address: ${place.name ?? ''} ${place.thoroughfare ?? ''} ${place.locality ?? ''} ${place.country ?? ''}
        ''';
      } else {
        _result = "❌ No address found for these coordinates";
      }
    } catch (e) {
      _result =
          "❌ Error: $e\n\nMake sure you entered valid coordinates.\nExample: Lat: 33.5138, Lng: 36.2765";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ✅ دالة 2: جلب الموقع الحالي
  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
        _result = "Getting location...";
      });

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _result = "❌ Location permission denied";
          setState(() => _isLoading = false);
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // تحديث الخريطة
      LatLng currentLocation = LatLng(position.latitude, position.longitude);
      _addMarkerAtPosition(currentLocation);
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 15),
      );
      setState(() {
        _selectedLocation = currentLocation;
        _latController.text = position.latitude.toString();
        _lngController.text = position.longitude.toString();
      });

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _result =
            '''
✅ Current Location Found!

📍 Coordinates: ${position.latitude}, ${position.longitude}
🎯 Accuracy: ${position.accuracy} meters
🏙️ Country: ${place.country ?? 'N/A'}
📍 City: ${place.locality ?? 'N/A'}
🏠 Street: ${place.thoroughfare ?? 'N/A'}

Full Address: ${place.name ?? ''} ${place.thoroughfare ?? ''} ${place.locality ?? ''} ${place.country ?? ''}
        ''';
      } else {
        _result = "📍 Coordinates: ${position.latitude}, ${position.longitude}";
      }
    } catch (e) {
      _result = "❌ Error: $e";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ✅ دالة 3: البحث عن مكان وتحويله لإحداثيات
  Future<void> _searchAddressToCoordinates() async {
    try {
      setState(() {
        _isLoading = true;
        _result = "Searching...";
      });

      String address = _addressController.text;

      if (address.isEmpty) {
        _result = "❌ Please enter an address to search";
        setState(() => _isLoading = false);
        return;
      }

      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations.first;

        // تحريك الخريطة إلى الموقع
        LatLng searchedLocation = LatLng(location.latitude, location.longitude);
        _addMarkerAtPosition(searchedLocation);
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(searchedLocation, 14),
        );
        setState(() {
          _selectedLocation = searchedLocation;
          _latController.text = location.latitude.toString();
          _lngController.text = location.longitude.toString();
        });

        // الحصول على العنوان التفصيلي
        List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        String addressDetails = "";
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          addressDetails =
              "\n\n📍 Address Details:\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
              "🏙️ Country: ${place.country ?? 'N/A'}\n"
              "🏙️ City: ${place.locality ?? 'N/A'}\n"
              "📍 Area: ${place.subLocality ?? 'N/A'}\n"
              "🏠 Street: ${place.thoroughfare ?? 'N/A'}";
        }

        _result =
            '''
✅ Address Found!

🔍 Searched: "$address"
📍 Coordinates: ${location.latitude}, ${location.longitude}
🗺️ Found ${locations.length} location(s)$addressDetails

💡 Tap on the map to select exact location!
        ''';
      } else {
        _result = "❌ No coordinates found for: $address";
      }
    } catch (e) {
      _result = "❌ Error: $e\n\nTry a more specific address";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ✅ دالة خاصة للخريطة عند الضغط على زر "Get My Location"
  Future<void> _getCurrentLocationOnMap() async {
    await _getCurrentLocation();
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    _addressController.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}
