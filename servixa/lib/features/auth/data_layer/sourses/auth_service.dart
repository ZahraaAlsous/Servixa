import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> register({
    required String first_name,
    required String last_name,
    // String email,
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Register IN");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/register",
        data: {
          "first_name": first_name,
          "last_name": last_name,
          // "email": email,
          if (email != null) "email": email,
          if (phone != null) "phone_number": phone,
          "password": password,
        },
        options: Options(headers: {"Accept": "application/json"}),
      );
      log("==============================Service : Register OK");
      if (response.statusCode == 200) {
        await storage.write(key: "email", value: email);
      }
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Register ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : Register ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }

  Future<void> login(String email, String password) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Login IN");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/login",
        data: {"email": email, "password": password},
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Login OK");
        await storage.write(
          key: "token",
          value: response.data["data"]["token"],
        );
        await storage.write(
          key: "user",
          value: jsonEncode(response.data["data"]["user"]),
        );
        // return response.data["data"]["user"];
        // return UserModel.fromJson(response.data["data"]["user"]);
      }
      // throw "Login failed: Unexpected response from server";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Login ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : Login ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }

  Future<bool> verifyEmail(String code) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Verify Email IN");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/verify-email",
        data: {
          "email": await storage.read(key: "email"),
          "code": code,
        },
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Verify Email OK");
        await storage.write(
          key: "token",
          value: response.data["data"]["token"],
        );
        await storage.write(
          key: "user",
          value: jsonEncode(response.data["data"]["user"]),
        );
        return true;
      }
      log("==============================Service : Verify Email HAVE_PROBLEM");
      return false;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Verify Email ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : Verify Email ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Device id : ${androidDeviceInfo.id}");
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  Future<bool> logout() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Logout IN");
      String? token = await storage.read(key: "token");

      String? deviceId = await getDeviceId();
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/logout",
        data: {"device_id": deviceId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Logout OK");
        return response.statusCode == 200;
      } else {
        log("==============================Service : Logout FAILED");
        throw "logout Failed";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Logout ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : Logout ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : ChangePassword IN");
      String? token = await storage.read(key: "token");

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/change-password",
        data: {"old_password": oldPassword, "new_password": newPassword},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service : ChangePassword OK");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : ChangePassword ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : ChangePassword ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }

  Future<bool> forgetPassword({required String email}) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: ForgetPassword IN");

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/forget-password",
        data: {"email": email},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: ForgetPassword OK");

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : ForgetPassword ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : ForgetPassword ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: ResetPassword OK");

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/reset-password",
        data: {"email": email, "code": code, "password": password},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : ResetPassword ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : ResetPassword ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }
}
