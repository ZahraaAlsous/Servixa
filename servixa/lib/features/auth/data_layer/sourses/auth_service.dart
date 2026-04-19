import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';

class AuthService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> register(
    String first_name,
    String last_name,
    String email, // String? email,
    // String? phone,
    String password,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Register IN");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/register",
        data: {
          "first_name": first_name,
          "last_name": last_name,
          "email": email, // if (email != null) "email": email,
          // if (phone != null) "phone_number": phone,
          "password": password,
        },
        options: Options(headers: {"Accept": "application/json"}),
      );
      log("==============================Service : Register OK");
      if (response.statusCode == 200) {
        // edit
        // إذا دخل فقط رقم و ما دخل email
        await storage.write(key: "email", value: email);
      }
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Register ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Register ERROR");
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
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Login ERROR");
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
        return true;
      }
      log("==============================Service : Verify Email HAVE_PROBLEM");
      return false;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Verify Email ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Verify Email ERROR");
      throw e.response!.data["message"];
    }
  }
}
