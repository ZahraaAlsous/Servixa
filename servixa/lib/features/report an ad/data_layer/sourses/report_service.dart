import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReportService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<void> addReport({
    required int adId,
    required String textReport,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: AddReport IN");
      String? token = await storage.read(key: "token");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/ads/report",
        data: {"ad_id": adId, "content": textReport},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("=================================Service: AddReport OK");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : AddReport ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("=================================Service: AddReport ERROR");
      log(
        "=================================The error is: ${e.response!.data["message"]}",
      );
      throw e.response!.data["message"];
    }
  }
}
