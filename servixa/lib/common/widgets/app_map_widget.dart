// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';

// class AppMapWidget extends StatelessWidget {
//   AppMapWidget({super.key});
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       height: 300,
//       width: size.width * 0.9139,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 4),
//             blurRadius: 4,
//             spreadRadius: -1,
//             color: Color.fromRGBO(12, 12, 13, 0.05),
//           ),
//           BoxShadow(
//             offset: Offset(0, 4),
//             blurRadius: 4,
//             spreadRadius: -1,
//             color: Color.fromRGBO(12, 12, 13, 0.1),
//           ),
//         ],
//         color: ThemeApp.whiteBackground,
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 234,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//             child: GoogleMap(
//               // mapType: MapType.hybrid,
//               mapType: MapType.normal,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//           ),

//           SizedBox(
//             width: size.width * 0.8465,
//             child: OutlinedButton(
//               // edit
//               onPressed: () {},
//               child: Text(
//                 "View Location",
//                 style: TypographyApp.Body_mid_Mid.copyWith(
//                   color: ThemeApp.Foundation_Main_main_500,
//                 ),
//               ),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(
//                   color: ThemeApp.Foundation_Main_main_500,
//                   width: 1,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class AppMapWidget extends StatelessWidget {
  AppMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      width: size.width * 0.9139,
      decoration: BoxDecoration(
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
        color: ThemeApp.whiteBackground,
      ),
      child: Column(
        children: [
          Container(
            height: 234,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          ),

          SizedBox(
            width: size.width * 0.8465,
            child: OutlinedButton(
              // edit
              onPressed: () {},
              child: Text(
                "View Location",
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Main_main_500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                // note
                // التأكد إذا الكل زاوية 16 ولا لا
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: ThemeApp.Foundation_Main_main_500,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
