import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';

class CategoryServic {
  final Dio dio = Dio();

  Future<List<CategoryModel>> getCategories() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Get Categories IN");
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/categories",
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Get Categories OK");
        return CategoryModel.listFromJson(response.data);
      } else {
        log("==============================Service : Get Categories Failed");

        throw "Failed to load categories";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Get Categories ERROR_Net");
        log(
          "==============================Service THE ERROR IS: " + e.toString(),
        );
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Get Categories ERROR");

      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }

  Future<List<CategoryModel>> getSubCategories(int? parent_id) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Get SubCategories IN");
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/categories",
        queryParameters: {if (parent_id != null) "parent_id": parent_id},
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (response.statusCode == 200) {
        log("==============================Service : Get SubCategories OK");
        return CategoryModel.listFromJson(response.data);
      } else {
        log("==============================Service : Get SubCategories Failed");

        throw "Failed to load Sub Categories";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log(
          "==============================Service : Get SubCategories ERROR_Net",
        );
        log(
          "==============================Service THE ERROR IS: " + e.toString(),
        );
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service : Get SubCategories ERROR");

      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }
}
