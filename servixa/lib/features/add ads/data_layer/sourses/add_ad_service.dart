import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class AddAdService {
  Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<AdsModel?> createAd({
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
    required String address,
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
        "price_currency": price_currency,
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
        "address": address,
      };

      // 2. دمج الأسئلة الديناميكية (custom_fields) داخل الـ Map
      dataMap.addAll(dynamicQuestions);

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
        // return true;
        return AdsModel.fromJson(response.data["data"]);
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

  // Future<bool> updateAd({
  //   required int adId,
  //   String? name,
  //   String? description,
  //   String? price,
  //   int? is_rent,
  //   int? category_id,
  //   File? main_image,
  //   String? existing_main_image_url,
  //   required String type,
  //   List<File>? other_images,
  //   List<String>? existing_sub_images_urls,
  //   Map<String, dynamic>? dynamicQuestions,
  //   double? lat,
  //   double? lng,
  //   String? price_currency,
  //   String? address,
  // }) async {
  //   try {
  //     log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : UpdateAd IN");
  //     String? token = await storage.read(key: "token");

  //     FormData formData = FormData();

  //     if (name != null) formData.fields.add(MapEntry("name", name));
  //     if (description != null)
  //       formData.fields.add(MapEntry("description", description));
  //     if (price != null) formData.fields.add(MapEntry("price", price));
  //     if (price_currency != null)
  //       formData.fields.add(MapEntry("price_currency", price_currency));
  //     if (is_rent != null)
  //       formData.fields.add(MapEntry("is_rent", is_rent.toString()));
  //     if (category_id != null)
  //       formData.fields.add(MapEntry("category_id", category_id.toString()));
  //     if (type.isNotEmpty) formData.fields.add(MapEntry("type", type));
  //     if (lat != null) formData.fields.add(MapEntry("lat", lat.toString()));
  //     if (lng != null) formData.fields.add(MapEntry("lng", lng.toString()));
  //     if (address != null) formData.fields.add(MapEntry("address", address));

  //     if (dynamicQuestions != null) {
  //       dynamicQuestions.forEach((key, value) {
  //         formData.fields.add(MapEntry(key, value.toString()));
  //       });
  //     }

  //     if (main_image != null) {
  //       formData.files.add(
  //         MapEntry(
  //           "main_image",
  //           await MultipartFile.fromFile(
  //             main_image.path,
  //             filename:
  //                 "main_image_${DateTime.now().millisecondsSinceEpoch}.jpg",
  //           ),
  //         ),
  //       );
  //     } else if (existing_main_image_url != null &&
  //         existing_main_image_url.isNotEmpty) {
  //       formData.fields.add(
  //         MapEntry("existing_main_image", existing_main_image_url),
  //       );
  //     }
  //     if (other_images != null && other_images.isNotEmpty) {
  //       for (int i = 0; i < other_images.length; i++) {
  //         formData.files.add(
  //           MapEntry(
  //             "other_images[]",
  //             await MultipartFile.fromFile(
  //               other_images[i].path,
  //               filename:
  //                   "sub_image_${i}_${DateTime.now().millisecondsSinceEpoch}.jpg",
  //             ),
  //           ),
  //         );
  //       }
  //     }

  //     if (existing_sub_images_urls != null &&
  //         existing_sub_images_urls.isNotEmpty) {
  //       for (String url in existing_sub_images_urls) {
  //         formData.fields.add(MapEntry("existing_sub_images[]", url));
  //       }
  //     }

  //     Response response = await dio.post(
  //       "https://services.tamkeen-dev.com/api/v1/ads/$adId",
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           "Accept": "application/json",
  //           "Content-Type": "multipart/form-data",
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       log("===============================Service : UpdateAd OK");
  //       log("Response: ${response.data}");
  //       return true;
  //     } else {
  //       log("===============================Service : UpdateAd Failed");
  //       log("Status code: ${response.statusCode}");
  //       log("Response: ${response.data}");
  //       throw response.data["message"] ?? "Update failed";
  //     }
  //   } on DioException catch (e) {
  //     log("===============================Service : UpdateAd ERROR");
  //     log("Error type: ${e.type}");
  //     log("Error message: ${e.message}");

  //     if (e.response != null) {
  //       log("Response data: ${e.response?.data}");
  //       log("Response status: ${e.response?.statusCode}");

  //       if (e.response?.data != null && e.response!.data["message"] != null) {
  //         throw e.response!.data["message"];
  //       }
  //     }

  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.connectionError) {
  //       throw "Connection failed. Please check your internet connection.";
  //     }

  //     throw "Failed to update ad: ${e.message}";
  //   } catch (e) {
  //     log("===============================Service : UpdateAd ERROR");
  //     log("Error: $e");
  //     throw "Unexpected error: $e";
  //   }
  // }
  Future<AdsModel> updateAd({
    required int adId,
    String? name,
    String? description,
    String? price,
    int? is_rent,
    int? category_id,
    File? main_image,
    String? existing_main_image_url,
    required String type,
    List<File>? other_images,
    // List<String>? existing_sub_images_urls,
    Map<String, dynamic>? dynamicQuestions,
    double? lat,
    double? lng,
    String? price_currency,
    String? address,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : UpdateAd IN");
      String? token = await storage.read(key: "token");

      FormData formData = FormData();

      if (name != null) formData.fields.add(MapEntry("name", name));
      if (description != null)
        formData.fields.add(MapEntry("description", description));
      if (price != null) formData.fields.add(MapEntry("price", price));
      if (price_currency != null)
        formData.fields.add(MapEntry("price_currency", price_currency));
      if (is_rent != null)
        formData.fields.add(MapEntry("is_rent", is_rent.toString()));
      if (category_id != null)
        formData.fields.add(MapEntry("category_id", category_id.toString()));
      if (type.isNotEmpty) formData.fields.add(MapEntry("type", type));
      if (lat != null) formData.fields.add(MapEntry("lat", lat.toString()));
      if (lng != null) formData.fields.add(MapEntry("lng", lng.toString()));
      if (address != null) formData.fields.add(MapEntry("address", address));

      if (dynamicQuestions != null) {
        dynamicQuestions.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      if (main_image != null) {
        formData.files.add(
          MapEntry(
            "main_image",
            await MultipartFile.fromFile(
              main_image.path,
              filename:
                  "main_image_${DateTime.now().millisecondsSinceEpoch}.jpg",
            ),
          ),
        );
      } else if (existing_main_image_url != null &&
          existing_main_image_url.isNotEmpty) {
        formData.fields.add(
          MapEntry("existing_main_image", existing_main_image_url),
        );
      }
      if (other_images != null && other_images.isNotEmpty) {
        for (int i = 0; i < other_images.length; i++) {
          formData.files.add(
            MapEntry(
              "images[]",
              await MultipartFile.fromFile(
                other_images[i].path,
                filename:
                    "sub_image_${i}_${DateTime.now().millisecondsSinceEpoch}.jpg",
              ),
            ),
          );
        }
      }

      // if (existing_sub_images_urls != null &&
      //     existing_sub_images_urls.isNotEmpty) {
      //   for (String url in existing_sub_images_urls) {
      //     formData.fields.add(MapEntry("images[]", url));
      //   }
      // }

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/ads/$adId",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("===============================Service : UpdateAd OK");
        log("Response: ${response.data}");
        // return true;
        return AdsModel.fromJson(response.data["data"]);
      } else {
        log("===============================Service : UpdateAd Failed");
        log("Status code: ${response.statusCode}");
        log("Response: ${response.data}");
        throw response.data["message"] ?? "Update failed";
      }
    } on DioException catch (e) {
      log("===============================Service : UpdateAd ERROR");
      log("Error type: ${e.type}");
      log("Error message: ${e.message}");

      if (e.response != null) {
        log("Response data: ${e.response?.data}");
        log("Response status: ${e.response?.statusCode}");

        if (e.response?.data != null && e.response!.data["message"] != null) {
          throw e.response!.data["message"];
        }
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw "Connection failed. Please check your internet connection.";
      }

      throw "Failed to update ad: ${e.message}";
    } catch (e) {
      log("===============================Service : UpdateAd ERROR");
      log("Error: $e");
      throw "Unexpected error: $e";
    }
  }

    Future<bool> deleteImage({required int adId, required int imageId}) async {
    try {
      log("=======================service: delete image IN");
      String? token = await storage.read(key: "token");

      Response response = await dio.delete(
        "https://services.tamkeen-dev.com/api/v1/ads/$adId/images/$imageId",

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      log("====================SERVICE: Delete image OK");
      return response.statusCode == 200;
    } on DioException catch (e) {
      log("=======================service: Delete image error");
      log(
        "=======================the error is : ${e.response!.data["message"]}",
      );
      throw e.response!.data["message"];
    }
  }
}
