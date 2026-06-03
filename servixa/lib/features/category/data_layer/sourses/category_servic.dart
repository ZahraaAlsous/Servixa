import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servixa/features/category/data_layer/models/category_model.dart';
import 'package:servixa/features/category/data_layer/models/category_question_model.dart';

class CategoryServic {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();

  Future<List<CategoryModel>> getCategories() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Get Categories IN");
      String currentLang =
          EasyLocalization.of(
            WidgetsBinding.instance.focusManager.primaryFocus?.context ??
                Colors.transparent as BuildContext,
          )?.locale.languageCode ??
          "en";
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/categories",
        options: Options(
          headers: {
            "Accept": "application/json",
            // 'Accept-Language': storage.read(key: "lang"),
            'Accept-Language': currentLang,
          },
        ),
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
        throw "Connection failed: Please check your internet".tr();
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
      String currentLang =
          EasyLocalization.of(
            WidgetsBinding.instance.focusManager.primaryFocus?.context ??
                Colors.transparent as BuildContext,
          )?.locale.languageCode ??
          "en";
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/categories",
        queryParameters: {if (parent_id != null) "parent_id": parent_id},
        options: Options(
          headers: {
            "Accept": "application/json",
            'Accept-Language': currentLang,
          },
        ),
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
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : Get SubCategories ERROR");

      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }

  Future<List<CategoryQuestionModel>> getCategoryQuestions(
    int categoryId,
  ) async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Get Category Questions IN");
      String currentLang =
          EasyLocalization.of(
            WidgetsBinding.instance.focusManager.primaryFocus?.context ??
                Colors.transparent as BuildContext,
          )?.locale.languageCode ??
          "en";
      Response response = await dio.get(
        "https://services.tamkeen-dev.com/api/v1/categories/$categoryId",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Accept-Language': currentLang,
          },
        ),
      );
      if (response.statusCode == 200) {
        log(
          "==============================Service : Get Category Questions OK",
        );
        return CategoryQuestionModel.listFromJson(
          response.data["data"]["custom_fields"],
        );
      } else {
        log(
          "==============================Service : Get Category Questions Failed",
        );

        throw "Failed to load category questions";
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
        throw "Connection failed: Please check your internet".tr();
      }
      log(
        "==============================Service : Get Category Questions ERROR",
      );
      log(
        "==============================Service THE ERROR IS: " + e.toString(),
      );
      throw e.response!.data["message"];
    }
  }
}
