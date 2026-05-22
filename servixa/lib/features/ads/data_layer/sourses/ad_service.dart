import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class AdService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<AdsModel> getAdDetails(int adId) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Ad Details IN");
      String? token = await storage.read(key: "token");

      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/ads/${adId}",
        // "https://services.tamkeen-dev.com/api/v1/ads/1",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            'Content-Type': 'application/json',
            'Accept-Language': 'en',
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Ad Details OK");
        log(
          "---------------------------------" +
              response.data["data"].toString(),
        );
        return AdsModel.fromJson(response.data["data"]);
      }
      throw "Get ad details failed: Unexpected response from server";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Ad Details ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Ad Details ERROR");
      throw e.response!.data["message"];
    }
  }

  Future<List<AdsModel>> getMyAds({required int page}) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : My Ads IN");
      String? token = await storage.read(key: "token");

      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/my-ads",
        queryParameters: {"page": page},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service : My Ads OK");
        List<AdsModel> adsList = AdsModel.listFromJson(response.data);
        return adsList;
      }
      throw "Get my ads failed: Unexpected response from server";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : My Ads ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : My Ads ERROR");
      log("==============================The Error is : $e");
      throw e.response!.data["message"];
    }
  }

  Future<bool> deleteAd(int adId) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Delete Ad IN");
      String? token = await storage.read(key: "token");
      Response response = await dio.delete(
        "https://services.tamkeen-dev.com/api/v1/ads/${adId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Delete Ad OK");
        return true;
      }
      throw "Delete ad failed: Unexpected response from server";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Delete Ad ERROR_Net");
        throw "Connection failed: Please check your internet";
      }

      log("==============================Service : Delete Ad ERROR");
      log("==============================The Error is : $e");
      throw e.response!.data["message"];
    }
  }

  Future<List<AdsModel>> getAds({int? categoryId}) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Ads IN");
      String? token = await storage.read(key: "token");
      // token = token?.trim();
      log("+++++++++++++++++++++++++++++++++token : $token");

      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/ads",
        queryParameters: {if (categoryId != null) "category_id": categoryId},

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            'Content-Type': 'application/json',
            'Accept-Language': 'en',
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Ads OK");
        log(response.data.toString());
        List<AdsModel> adsList = AdsModel.listFromJson(response.data);
        return adsList;
      }
      log("==============================Service : Ads Failed");

      throw "Get ads failed: Unexpected response from server";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Delete Ad ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Ads ERROR");
      throw e.response!.data["message"];
    }
  }
}
