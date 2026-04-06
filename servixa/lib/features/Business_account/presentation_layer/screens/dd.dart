import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationPage extends StatefulWidget {
  @override
  _CurrentLocationPageState createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  GoogleMapController? _controller;
  LatLng _initialPosition = LatLng(33.5138, 36.2765); // موقع افتراضي (دمشق)
  Marker? _userMarker;

  Future<void> _getUserLocation() async {
    // 1. التحقق من الأذونات
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // 2. جلب الموقع
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    // 3. تحديث الخريطة والعلامة
    setState(() {
      _userMarker = Marker(
        markerId: MarkerId("current_loc"),
        position: currentLatLng,
        infoWindow: InfoWindow(title: "موقعك الحالي"),
      );
    });

    _controller?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تحديد الموقع الحالي")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        onMapCreated: (controller) => _controller = controller,
        markers: _userMarker != null ? {_userMarker!} : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
