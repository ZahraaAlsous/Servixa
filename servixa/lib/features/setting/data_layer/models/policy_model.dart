class PolicyModel {
  final String key;
  final String value;

  PolicyModel({required this.key, required this.value});

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(key: json["key"], value: json["value"]);
  }

  static List<PolicyModel> listFromJson(Map<String, dynamic> json) {
    List<PolicyModel> policies = [];
    for (var item in json["data"]) {
      policies.add(PolicyModel.fromJson(item));
    }
    return policies;
  }
}
