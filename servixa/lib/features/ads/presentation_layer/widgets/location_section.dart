import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';
import 'package:servixa/features/ads/presentation_layer/widgets/bottom_sheet_portfolio_widget.dart';

class LocationSection extends StatelessWidget {
  final AdsModel ads;
  LocationSection({super.key, required this.ads});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<String> getAddressName() async {
    try {
      if (ads.lat == null || ads.lng == null) return "Unknown Location";

      List<Placemark> placemarks = await placemarkFromCoordinates(
        ads.lat!,
        ads.lng!,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}";
      }
      return "Location not found";
    } catch (e) {
      return "Error fetching location";
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = Get.width;
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(ads.lat!, ads.lng!),
      zoom: 14.4746,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widthScreen * DimensApp.spaceHorizontalScreen,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TypographyApp.Title_larg_Mid.copyWith(
              color: ThemeApp.Foundation_Main_Color_900,
            ),
          ),

          FutureBuilder<String>(
            future: getAddressName(),
            builder: (context, snapshot) {
              String addressText = "Loading address...";
              if (snapshot.hasData) {
                addressText = snapshot.data!;
              } else if (snapshot.hasError) {
                addressText = "Error loading location";
              }

              return Row(
                children: [
                  SvgPicture.asset(IconApp.place),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      addressText,
                      style: TypographyApp.Body_mid_Regular.copyWith(
                        color: ThemeApp.Foundation_Secendary_grey_300,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 10),

          Container(
            width: widthScreen * 0.9255,
            height: 329,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ThemeApp.whiteBackground,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: -1,
                  color: Color.fromRGBO(12, 12, 13, 0.05),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('adsLocation'),
                          position: LatLng(ads.lat!, ads.lng!),
                        ),
                      },
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            isDismissible: true,
                            enableDrag: true,
                            BottomSheetPortfolioWidget(),
                          );
                        },
                        child: CircleAvatar(
                          // radius: size.width * 0.100,
                          radius: widthScreen * 0.100,
                          // radius: 36,
                          // edit
                          // الصورة ما عم تطلع
                          backgroundImage: AssetImage(ImageApp.profileImage),
                          // backgroundImage: selectedImage != null
                          //     ? FileImage(selectedImage!)
                          //     : (user.img!.isNotEmpty ? NetworkImage(user.img!) : null),
                          // child: user.img!.isEmpty && selectedImage == null
                          //     ? const Icon(Icons.person, size: 60)
                          //     : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Mhamad Alshame",
                            "${ads.user.firstName} ${ads.user.lastName}",
                            style: TypographyApp.Title_Mid_Mid.copyWith(
                              color: ThemeApp.Foundation_Grey_grey_700,
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // qustion
                              // مو من مكتبة الألوان
                              // Icon(Icons.place_outlined, color: Color(0xff6D3FAE)),
                              SvgPicture.asset(
                                IconApp.place,
                                width: 16,
                                height: 16,
                                color: ThemeApp.colorIconProfileHomeScreen,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Riyadh – Malaz",
                                style: TypographyApp.Label_Mid_Regular.copyWith(
                                  color: ThemeApp.Foundation_Secendary_grey_600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    Expanded(
                      flex: 10,
                      child: SvgPicture.asset(
                        IconApp.messages,
                        width: 29,
                        height: 29,
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: SvgPicture.asset(
                        IconApp.phone,
                        width: 29,
                        height: 29,
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
