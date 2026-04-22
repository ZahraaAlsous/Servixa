import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<void> updateProfile(Map<String, dynamic> updatedFields) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Update Profile IN");
      String? token = await storage.read(key: "token");
      FormData formData = FormData.fromMap(updatedFields);
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/update-profile",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("===============================Service : Update Profile OK");
        await storage.write(
          key: "user",
          value: jsonEncode(response.data["data"]),
        );
      } else {
        log("===============================Service : Update Profile Failed");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log(
          "===============================Service : Update Profile ERROR_Net",
        );
        log(
          "===============================Service THE ERROR IS: " +
              e.toString(),
        );
        throw "Connection failed: Please check your internet";
      }
      log("===============================Service : Update Profile ERROR");
      log(
        "===============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }
}
