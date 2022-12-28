class RewardHistory {
  RewardHistory({
    required this.rewardName,
    required this.iconUrl,
    required this.point,
    this.message,
    required this.createdAt
  });

  final String rewardName;
  final String iconUrl;
  final int point;
  final String? message;
  final String createdAt;

  static RewardHistory fromJson(Map<String, dynamic> json) {
    return RewardHistory(
      rewardName: json['name'],
      iconUrl: json['messageUserIconUrl'],
      point: json['point'],
      message: json['message'],
      createdAt: json['createdAt']
    );
  }
}
