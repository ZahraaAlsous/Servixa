import 'package:servixa/features/rate/data_layer/models/rate_model.dart';
import 'package:servixa/features/rate/data_layer/models/statistics_model.dart';

class ReviewRateModel {
  StatisticsModel statistics;
  List<RateModel> ratings;

  ReviewRateModel({
    required this.statistics, 
    required this.ratings
    });

  factory ReviewRateModel.fromJson(Map<String, dynamic> json) {
    return ReviewRateModel(
      statistics: StatisticsModel.fromJson(json["data"]["statistics"]),
      ratings: RateModel.listFromJson(json["data"]),
    );
  }
}
