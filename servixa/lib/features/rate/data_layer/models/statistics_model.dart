class StatisticsModel {
  double averageRating;
  int totalRatings;
  double ratingPercentagesOne;
  double ratingPercentagesTwo;
  double ratingPercentagesThree;
  double ratingPercentagesFour;
  double ratingPercentagesFive;

  StatisticsModel({
    required this.averageRating,
    required this.totalRatings,
    required this.ratingPercentagesOne,
    required this.ratingPercentagesTwo,
    required this.ratingPercentagesThree,
    required this.ratingPercentagesFour,
    required this.ratingPercentagesFive,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      // averageRating: json["average_rating"],
      averageRating: (json["average_rating"] as num).toDouble(),
      totalRatings: json["total_ratings"],
      // ratingPercentagesOne: json["rating_percentages"]["1"],
      // ratingPercentagesTwo: json["rating_percentages"]["2"],
      // ratingPercentagesThree: json["rating_percentages"]["3"],
      // ratingPercentagesFour: json["rating_percentages"]["4"],
      // ratingPercentagesFive: json["rating_percentages"]["5"],
      ratingPercentagesOne: (json["rating_percentages"]["1"] as num).toDouble(),
      ratingPercentagesTwo: (json["rating_percentages"]["2"] as num).toDouble(),
      ratingPercentagesThree: (json["rating_percentages"]["3"] as num)
          .toDouble(),
      ratingPercentagesFour: (json["rating_percentages"]["4"] as num)
          .toDouble(),
      ratingPercentagesFive: (json["rating_percentages"]["5"] as num)
          .toDouble(),
    );
  }
}
