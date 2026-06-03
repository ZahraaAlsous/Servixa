import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class FavoriteService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> addToFavorite({required int adId}) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: AddToFavorite IN");
      String? token = await storage.read(key: "token");

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/favorites",
        data: {"ad_id": adId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("==============================Service: AddToFavorite OK");
        return true;
      }
      log("==============================Service: AddToFavorite FAILED");
      return false;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : AddToFavorite ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service: AddToFavorite ERROR");
      log(
        "==============================The error is: ${e.response!.data["message"]}",
      );

      throw e.response!.data["message"];
    }
  }

  Future<List<AdsModel>> getMyFavorite() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: GetMyFavorite IN");
      String? token = await storage.read(key: "token");

      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/favorites",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      return AdsModel.listFromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : GetMyFavorite ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service: GetMyFavorite ERROR");
      log(
        "==============================The error is: ${e.response!.data["message"]}",
      );

      throw e.response!.data["message"];
    }
  }
}
