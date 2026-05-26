import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/profile/data_layer/models/user_model.dart';

class ProfileService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<UserModel> updateProfile(
    Map<String, dynamic> updatedFields, {
    File? imageFile,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Update Profile IN");

      String? token = await storage.read(key: "token");
      FormData formData = FormData();

      updatedFields.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      if (imageFile != null) {
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              imageFile.path,
              filename: "profile_${DateTime.now().millisecondsSinceEpoch}.jpg",
            ),
          ),
        );
        log("New profile image added to form data");
      }
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/update-profile",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("===============================Service : Update Profile OK");
        final responseData = response.data["data"];

        UserModel updatedUser = UserModel.fromJson(responseData);

        await storage.write(
          key: "user",
          value: jsonEncode(updatedUser.toJson()),
        );

        return updatedUser;
      } else {
        log("===============================Service : Update Profile Failed");
        log("Response: ${response.data}");
        throw "Update failed with status code: ${response.statusCode}";
      }
    } on DioException catch (e) {
      log("===============================Service : Update Profile ERROR");
      log(
        "==============================Service: THE ERROR IS: " + e.toString(),
      );
      throw e.response?.data["message"];
    }
  }
}
