import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddAdService {
  Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> createAd({
    required int business_account_id,
    required String name,
    required String description,
    // required double price,
    required String price,
    required int is_rent,
    required int category_id,
    required File main_image,
    // required int type,
    required String type,
    required List<File> other_images,
    required Map<String, dynamic> dynamicQuestions,
    required double lat,
    required double lng,
    required String price_currency,
    required String address
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : CreateAd IN");
      String? token = await storage.read(key: "token");

      // 1. تجهيز الخريطة الأساسية للبيانات
      Map<String, dynamic> dataMap = {
        "business_account_id": business_account_id,
        "name": name,
        "description": description,
        "price": price,
        "price_currency" : price_currency,
        "is_rent": is_rent,
        "category_id": category_id,
        "type": type,
        // إضافة الصورة الأساسية
        "main_image": await MultipartFile.fromFile(
          main_image.path,
          filename: "main.jpg",
        ),
        "lat": lat,
        "lng": lng,
        "address": address
      };

      // 2. دمج الأسئلة الديناميكية (custom_fields) داخل الـ Map
      dataMap.addAll(dynamicQuestions);

      // 3. إضافة مصفوفة الصور الإضافية بنفس التنسيق المطلوب images[0], images[1]
      for (int i = 0; i < other_images.length; i++) {
        dataMap["images[$i]"] = await MultipartFile.fromFile(
          other_images[i].path,
          filename: "image_$i.jpg",
        );
      }

      // 4. تحويل الـ Map إلى FormData
      FormData formData = FormData.fromMap(dataMap);

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/ads",
        data: formData, // نرسل الـ formData هنا
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("=======================service : ok");
        return true;
      }
      log("Response: ${response.data}");
      throw response.data["message"] ?? "Unknown error";
    } on DioException catch (e) {
      log("=======================service: error");
      log("=======================the error");
      log(e.response!.data["message"]);
      throw e.response!.data["message"];
    }
  }
}
