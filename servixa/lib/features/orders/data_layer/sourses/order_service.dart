import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> addOrder({
    required int adId,
    required String note,
    required int quantity,
    required int businessAccountId,
    required String fromDate,
    required String toDate
  }) async {
    try {
      String? token = await storage.read(key: "token");
   Response response =    await dio.post(
        "https://services.tamkeen-dev.com/api/v1/orders",
        data: {
          "ads": [
            {
              "ad_id": adId,
              "note": note,
              "quantity": quantity,
              "business_account_id": businessAccountId,
              "from_date": fromDate,
              "to_date": toDate
            },
          ],
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : AddOrder ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : AddOrder ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );

      throw e.response!.data["message"];
    }
  }
}
