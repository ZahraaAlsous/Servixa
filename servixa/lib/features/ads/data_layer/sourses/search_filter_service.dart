import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:servixa/features/ads/data_layer/models/ads_model.dart';

class SearchFilterService {
  final Dio dio = Dio();
  Future<List<AdsModel>> getAds({
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? isRent,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : AdsFilter IN");
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/ads",
        queryParameters: {
          if (categoryId != null) "category_id": categoryId,
          if (minPrice != null) "min_price": minPrice,
          if (maxPrice != null) "max_price": maxPrice,
          if (isRent != null) "is_rent": isRent,
        },
      );

      log(categoryId.toString());
      if (response.statusCode == 200) {
        log("==============================Service : AdsFilter OK");
        log(response.data.toString());
        List<AdsModel> adsList = AdsModel.listFromJson(response.data);
        log(adsList.toString());
        return adsList;
      }
      log("==============================Service : AdsFilter Failed");

      throw "Get ads failed: Unexpected response from server";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : AdsFilter ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : AdsFilter ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }
}
