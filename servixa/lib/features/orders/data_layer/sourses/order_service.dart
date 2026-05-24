import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';

class OrderService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<bool> addOrder({
    required int adId,
    required String note,
    required int quantity,
    required int businessAccountId,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/orders",
        data: {
          "ads": [
            {
              "ad_id": adId,
              "note": note,
              "quantity": quantity,
              "business_account_id": businessAccountId,
              "from_date": fromDate,
              "to_date": toDate,
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

  Future<List<OrdersModel>> getOrders({required int isMyOrders}) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: GetOrders IN");

      String? token = await storage.read(key: "token");
      String currentLang =
          EasyLocalization.of(
            WidgetsBinding.instance.focusManager.primaryFocus?.context ??
                Colors.transparent as BuildContext,
          )?.locale.languageCode ??
          "en";

      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/orders",
        queryParameters: {"my_orders": isMyOrders},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            'Accept-Language': currentLang,
          },
        ),
      );
      log("==============================Service: GetOrders OK");

      return OrdersModel.listFromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : GetOrder ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : GetOrder ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }

  Future<bool> deleteOrder({required int orderId}) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: DeleteOrder IN");

      String? token = await storage.read(key: "token");

      Response response = await dio.delete(
        "https://services.tamkeen-dev.com/api/v1/orders/$orderId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      log("==============================Service : DeleteOrder OK");

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : DeleteOrder ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : DeleteOrder ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }

  Future<bool> updateStatusOrder({
    required int orderId,
    required int status,
  }) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: UpdateStatusOrder IN");

      String? token = await storage.read(key: "token");

      Response response = await dio.post(
        "https://services.tamkeen-dev.com/api/v1/orders/$orderId",
        data: {"status": status},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
          },
        ),
      );
      log("==============================Service : UpdateStatusOrder OK");

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log(
          "==============================Service : UpdateStatusOrder ERROR_Net",
        );
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : UpdateStatusOrder ERROR");
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }
}
