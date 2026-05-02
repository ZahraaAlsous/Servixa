import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:servixa/features/Business_account/data_layer/models/city_model.dart';

class BusinessAccountService {
  final Dio dio = Dio();

  Future<List<CityModel>> getCities() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : GetCities IN");
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/cities",
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (response.statusCode == 200) {
        log("==============================Service : GetCities OK");
      } else {
        log("==============================Service : GetCities FAILED");
      }
      return CityModel.listFromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : GetCities ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : GetCities ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }
}
