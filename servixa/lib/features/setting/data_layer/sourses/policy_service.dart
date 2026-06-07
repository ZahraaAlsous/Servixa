import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:servixa/features/setting/data_layer/models/policy_model.dart';

class PolicyService {
  final Dio dio = Dio();

  Future<List<PolicyModel>> getPolicies() async {
    try {
      final response = await dio.get('https://services.tamkeen-dev.com/api/v1/settings');
      return PolicyModel.listFromJson(response.data);
    }on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : Get Policy ERROR_Net");
        throw "Connection failed: Please check your internet".tr();
      }
      log("==============================Service : Get Policy ERROR");
      throw e.response!.data["message"];
    }
  }
  
}