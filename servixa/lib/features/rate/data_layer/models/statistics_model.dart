class StatisticsModel {
  int averageRating;
  int totalRatings;
  int ratingPercentagesOne;
  int ratingPercentagesTwo;
  int ratingPercentagesThree;
  int ratingPercentagesFour;
  int ratingPercentagesFive;

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
      averageRating: json["average_rating"],
      totalRatings: json["total_ratings"],
      ratingPercentagesOne: json["rating_percentages"]["1"],
      ratingPercentagesTwo: json["rating_percentages"]["2"],
      ratingPercentagesThree: json["rating_percentages"]["3"],
      ratingPercentagesFour: json["rating_percentages"]["4"],
      ratingPercentagesFive: json["rating_percentages"]["5"],
    );
  }
}
