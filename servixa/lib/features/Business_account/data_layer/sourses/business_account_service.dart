import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';
import 'package:servixa/features/Business_account/data_layer/models/user_type_model.dart';

class BusinessAccountService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<List<UserTypeModel>> getUserTypes() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : getUserTypes IN");

      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/user-types",
      );
      if (response.statusCode == 200) {
        log("==============================Service : getUserTypes OK");
      } else {
        log("==============================Service : getUserTypes FAILED");
      }
      return UserTypeModel.listFromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : getUserTypes ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : getUserTypes ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }

  Future<List<CityModel>> getCities() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : GetCities IN");
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/cities",
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (response.statusCode == 200) {
        log("==============================Service : GetCities OK");
      } else {
        log("==============================Service : GetCities FAILED");
      }
      return CityModel.listFromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : GetCities ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : GetCities ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }

  // Future<void> createBusinessAccount({
  //   required int user_type_id,
  //   required int city_id,
  //   required String business_nameAr,
  //   required String business_nameEn,
  //   required String license_number,
  //   required String business_address,
  //   required String activities,
  //   required String details,
  //   required double lat,
  //   required double lng,
  //   required List<File> documents,
  // }) async {
  //   try {
  //     String? token = await storage.read(key: "token");

  //     Response response = await dio.post(
  //       "https://services.tamkeen-dev.com/api/v1/business-accounts",
  //       data: {
  //         "user_type_id": user_type_id.toString(),
  //         "city_id": city_id.toString(),
  //         "business_name[ar]": business_nameAr,
  //         "business_name[en]": business_nameEn,
  //         "license_number": license_number,
  //         "business_address": business_address,
  //         "activities": activities,
  //         "details": details,
  //         "lat": lat,
  //         "lng": lng,
  //         "documents[]": documents,
  //       },
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           "Accept": "application/json",
  //           "Content-Type": "application/json",
  //         },
  //       ),
  //     );
  //   } on DioException catch (e) {}
  // }
  Future<void> createBusinessAccount({
    required int user_type_id,
    required int city_id,
    required String business_nameAr,
    required String business_nameEn,
    required String license_number,
    required String business_address,
    required String activities,
    required String details,
    required double lat,
    required double lng,
    List<File>? documents,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : CreateBusinessAccount IN");

      String? token = await storage.read(key: "token");

      Map<String, dynamic> dataMap = {
        "user_type_id": user_type_id,
        "city_id": city_id,
        "business_name[ar]": business_nameAr,
        "business_name[en]": business_nameEn,
        "license_number": license_number,
        "business_address": business_address,
        "activities": activities,
        "details": details,
        "lat": lat,
        "lng": lng,
      };

      if (documents != null && documents.isNotEmpty) {
        dataMap["documents[]"] = await Future.wait(
          documents.map(
            (file) async => await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }

      FormData formData = FormData.fromMap(dataMap);

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/business-accounts",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Get.snackbar("Success", "Account created successfully");
        log("==============================Service : CreateBusinessAccount OK");
        // throw "Account created successfully";
      }
      log(
        "==============================Service : CreateBusinessAccount Failed",
      );

      // throw "Account created Failed";
    } on DioException catch (e) {
      // String errorMessage =
      //     e.response?.data['message'] ?? "Something went wrong";
      // Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
      // print("Dio Error: ${e.response?.data}");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log(
          "==============================Service : CreateBusinessAccount ERROR_Net",
        );
        throw "Connection failed: Please check your internet";
      }
      log(
        "==============================Service : CreateBusinessAccount ERROR",
      );
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }
}
