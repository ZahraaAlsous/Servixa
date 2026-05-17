import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RateService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> addRate({
    required int adId,
    required int rate,
    String? comment,
  }) async {
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/ratings",
        data: {
          "ad_id": adId,
          "rate": rate,
          if (comment != null) "comment": comment,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : AddRate ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : AddRate ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      if (e.response!.statusCode == 422) {
        throw "You must have an order for this service and the order status must be \"accepted\".";
      }

      throw e.response!.data["message"];
    }
  }
}
