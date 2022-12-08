class FamilyReward {
  FamilyReward({
    required this.userName,
    required this.iconUrl,
  });

  final String userName;
  final String iconUrl;

  static FamilyReward fromJson(Map<String, dynamic> json) {
    return FamilyReward(
      userName: json['user']['userName'],
      iconUrl: json['user']['iconUrl']
    );
  }
}
