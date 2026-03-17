class BusinessAccountModel {
  int id;
  // edit
  // يمكنبيقصد ال category
  String typeBusinessAccount;
  int licenseNumber;
  String businessNameArabic;
  String businessNameEnglish;
  String activities;
  String details;
  String city;
  String addressDetail;
  String location;
  // edit
  // صورة ولا عدة صور
  String? image;
  List<String> doc;
  String status; //Account under review / Accepted / Rejected

  BusinessAccountModel({
    required this.id,
    required this.businessNameArabic,
    required this.businessNameEnglish,
    required this.typeBusinessAccount,
    required this.licenseNumber,
    required this.city,
    required this.addressDetail,
    required this.location,
    required this.activities,
    required this.details,
    required this.doc,
    this.image,
    required this.status
  });
}
