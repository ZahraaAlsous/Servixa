import 'package:easy_localization/easy_localization.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/document_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/user_type_model.dart';

class BusinessAccountModel {
  int id;
  UserTypeModel typeBusinessAccount;
  String licenseNumber;
  String businessNameArabic;
  String businessNameEnglish;
  String activities;
  String details;
  CityModel? city;
  String addressDetail;
  double? lat;
  double? lng;
  // String location;
  List<DocumentModel>? documents;
  String status; //Account under review / Accepted / Rejected
  UserTypeModel? userType;
  String? approvedAt;
  String? rejectReason;
   String? createdAt;
  String? updatedAt;

  BusinessAccountModel({
    required this.id,
    required this.businessNameArabic,
    required this.businessNameEnglish,
    required this.typeBusinessAccount,
    required this.licenseNumber,
    this.city,
    required this.addressDetail,
    this.lat,
    this.lng,
    // required this.location,
    required this.activities,
    required this.details,
    this.documents,
    // this.image,
    required this.status,
    this.userType,
    this.approvedAt,
    this.rejectReason,
    this.createdAt,
    this.updatedAt,
  });

  String getFormattedApprovedDate() {
    if (approvedAt == null || approvedAt!.isEmpty) return "Not available".tr();

    try {
      DateTime date = DateTime.parse(approvedAt!);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return approvedAt!;
    }
  }

  static String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';

    try {
      DateTime dateTime = DateTime.parse(dateString);
      return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }

  factory BusinessAccountModel.fromJson(Map<String, dynamic> json) {
    return BusinessAccountModel(
      id: json["id"],
      // businessNameArabic: json["business_name"]["ar"],
      businessNameArabic: "jjjjj",
      businessNameEnglish: json["business_name"],
      typeBusinessAccount: UserTypeModel.fromJson(json["user_type"]),
      licenseNumber: json["license_number"],
      city: json["city"] != null ? CityModel.fromJson(json["city"]) : null,
      addressDetail: json["business_address"],
      lat: json["lat"] != null ? double.tryParse(json["lat"].toString()) : null,
      lng: json["lng"] != null ? double.tryParse(json["lng"].toString()) : null,
      // location: json["location"],
      activities: json["activities"],
      details: json["details"],
      // documents: List<String>.from(json["documents"]),
      documents: json["documents"] != null
          ? DocumentModel.listFromJson(json["documents"])
          : null,
      // image: json["image"],
      status: json["status"],
      userType: json["user_type"] != null
          ? UserTypeModel.fromJson(json["user_type"])
          : null,
      approvedAt: formatDate(json["approved_at"]),
      // approvedAt: json["approved_at"],
      rejectReason: json["reject_reason"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  static List<BusinessAccountModel> listFromJson(Map<String, dynamic> json) {
    List<BusinessAccountModel> businessAccounts = [];
    for (var item in json["data"]) {
      businessAccounts.add(BusinessAccountModel.fromJson(item));
    }
    return businessAccounts;
  }
}
