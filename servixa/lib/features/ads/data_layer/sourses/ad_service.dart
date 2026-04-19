import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class AdService {
  final Dio dio = Dio();

  Future<AdsModel> getAdDetails(int adId) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Ad Details IN");
      Response response = await dio.get(
        // "https://services.tamkeen-dev.com/api/v1/ads/${adId}",
        "https://services.tamkeen-dev.com/api/v1/ads/1",
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
}
