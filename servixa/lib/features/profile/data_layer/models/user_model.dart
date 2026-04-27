class UserModel {
  int id;
  String firstName;
  String lastName;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? phoneVerifiedAt;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String name;
  String? image;
  dynamic currentLevel;
  bool? hasBusinessAccount;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.image,
    this.currentLevel,
    this.hasBusinessAccount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone_number'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      phoneVerifiedAt: json['phone_verified_at'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      image: json['image'],
      currentLevel: json['current_level'],
      hasBusinessAccount: json['has_business_account'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phone,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone_verified_at': phoneVerifiedAt,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'image': image,
      'current_level': currentLevel,
      'has_business_account': hasBusinessAccount,
    };
  }
}
