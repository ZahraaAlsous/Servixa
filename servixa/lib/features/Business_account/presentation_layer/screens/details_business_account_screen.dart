import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/services/url_launcher_service%20.dart';
import 'package:servixa/features/Business_account/business_later/busiess_account_controller.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';

class BusinessAccountDetailsScreen extends StatelessWidget {
  final BusinessAccountController businessAccountController = Get.put(
    BusinessAccountController(),
  );
  final BusinessAccountModel account;

  BusinessAccountDetailsScreen({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeApp.whiteBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * DimensApp.spaceHorizontalScreen,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            // ✅ بطاقة الحالة والاسم (Header)
            _buildHeaderCard(),
            const SizedBox(height: 16),

            // ✅ بطاقة المعلومات الرئيسية
            _buildMainInfoCard(),
            const SizedBox(height: 16),

            // ✅ الموقع على الخريطة
            if (account.lat != null && account.lng != null) _buildMapCard(),
            const SizedBox(height: 16),

            // ✅ المستندات
            if (account.documents != null && account.documents!.isNotEmpty)
              _buildDocumentsCard(),
            const SizedBox(height: 16),

            // ✅ التواريخ
            // _buildDatesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (account.status) {
      case "approved":
        statusColor = ThemeApp.Foundation_Statue_Green;
        statusText = "Approved".tr();
        statusIcon = Icons.check_circle;
        break;
      case "rejected":
        statusColor = ThemeApp.Foundation_Statue_Red;
        statusText = "Rejected".tr();
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = ThemeApp.Foundation_Secendary_grey_300;
        statusText = "Pending".tr();
        statusIcon = Icons.hourglass_empty;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            account.status == "approved"
                ? ThemeApp.Foundation_Main_main_500
                : account.status == "rejected"
                ? ThemeApp.Foundation_Statue_Red
                : ThemeApp.Foundation_Secendary_grey_300,
            ThemeApp.Foundation_Main_main_300,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ThemeApp.Foundation_Main_main_500.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.business,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.businessNameEnglish,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      account.typeBusinessAccount.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (account.rejectReason != null) ...[
            const SizedBox(height: 8),
            Text(
              "Reason: ${account.rejectReason}",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeApp.Foundation_Secendary_grey_50),
        color: ThemeApp.whiteBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ThemeApp.Foundation_Main_main_500,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Information".tr(),
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailItem(
            icon: Icons.numbers,
            label: "License Number".tr(),
            value: account.licenseNumber,
          ),
          _buildDetailItem(
            icon: Icons.work_outline,
            label: "Activities".tr(),
            value: account.activities,
          ),
          _buildDetailItem(
            icon: Icons.description_outlined,
            label: "Details".tr(),
            value: account.details,
          ),
          _buildDetailItem(
            icon: Icons.location_on_outlined,
            label: "Address".tr(),
            value: account.addressDetail,
          ),
          if (account.city != null)
            _buildDetailItem(
              icon: Icons.location_city,
              label: "City".tr(),
              value: account.city!.name,
            ),
          if (account.approvedAt != null && account.approvedAt!.isNotEmpty)
            _buildDetailItem(
              icon: Icons.date_range,
              label: "Approved".tr(),
              value: account.approvedAt!,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 24),
          Icon(icon, size: 18, color: ThemeApp.Foundation_Secendary_grey_400),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TypographyApp.Label_Mid_Regular.copyWith(
                    color: ThemeApp.Foundation_Secendary_grey_400,
                  ),
                ),
                Text(
                  value,
                  style: TypographyApp.Body_mid_Regular.copyWith(
                    color: ThemeApp.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard() {
    final latLng = LatLng(account.lat!, account.lng!);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeApp.Foundation_Secendary_grey_50),
        color: ThemeApp.whiteBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.map,
                color: ThemeApp.Foundation_Main_main_500,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Location".tr(),
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('business_location'),
                    position: latLng,
                    infoWindow: InfoWindow(
                      title: account.businessNameEnglish,
                      snippet: account.addressDetail,
                    ),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                onTap: (_) {
                  Get.to(() => BusinessLocationMapScreen(account: account));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeApp.Foundation_Secendary_grey_50),
        color: ThemeApp.whiteBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_open,
                color: ThemeApp.Foundation_Main_main_500,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Documents".tr(),
                style: TypographyApp.Title_Mid_Mid.copyWith(
                  color: ThemeApp.black,
                ),
              ),
              const Spacer(),
              Text(
                "${account.documents!.length} files",
                style: TypographyApp.Label_Mid_Regular.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...account.documents!.map((doc) {
            return ListTile(
              leading: Icon(
                doc.url.endsWith('.pdf')
                    ? Icons.picture_as_pdf
                    : Icons.description,
                color: doc.url.endsWith('.pdf') ? Colors.red : Colors.blue,
                size: 30,
              ),
              title: Text(
                doc.name,
                style: TypographyApp.Body_mid_Regular.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: TextButton(
                onPressed: () => UrlLauncherService.openUrl(Uri.parse(doc.url)),
                child: Text(
                  "View".tr(),
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    color: ThemeApp.Foundation_Main_main_500,
                  ),
                ),
              ),

            );
          }),
        ],
      ),
    );
  }
}

class BusinessLocationMapScreen extends StatelessWidget {
  final BusinessAccountModel account;

  const BusinessLocationMapScreen({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(account.lat!, account.lng!);

    return Scaffold(
      appBar: AppBar(
        title: Text(account.businessNameEnglish),
        backgroundColor: ThemeApp.Foundation_Main_main_500,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: latLng, zoom: 15.0),
        markers: {
          Marker(
            markerId: const MarkerId('business_location'),
            position: latLng,
            infoWindow: InfoWindow(
              title: account.businessNameEnglish,
              snippet: account.addressDetail,
            ),
          ),
        },
        zoomControlsEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
