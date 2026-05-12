import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:servixa/features/home/data_layer/models/image_slider_model.dart';

class HomeService {
  final Dio dio = Dio();

  Future<List<ImageSliderModel>> getImageSliders() async {
    try {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service: getImageSliders IN");
      final response = await dio.get(
        'https://services.tamkeen-dev.com/api/v1/sliders',
      );
      if (response.statusCode == 200) {
        log("==============================Service: getImageSliders IN");
        return ImageSliderModel.listFromJson(response.data);
      } else {
        log("==============================Service: getImageSliders FAILED");

        throw Exception('Failed to load image sliders');
      }
    } on DioException catch (e) {

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        log("==============================Service : getImageSliders ERROR_Net");
        throw "Connection failed: Please check your internet";
      }
      log("==============================Service: getImageSliders ERROR");
      log(
        "==============================The error is: ${e.response!.data['message']}",
      );
      throw e.response!.data['message'];
    }
  }
}
