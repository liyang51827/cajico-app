class PointHistory {
  PointHistory({
    required this.userName,
    required this.iconUrl,
    required this.todayPoint,
    required this.totalPoint,
  });

  final String userName;
  final String iconUrl;
  final int todayPoint;
  final int totalPoint;

  static PointHistory fromJson(Map<String, dynamic> json) {
    return PointHistory(
      userName: json['user']['userName'],
      iconUrl: json['user']['iconUrl'],
      todayPoint: json['todayPoint'],
      totalPoint: json['totalPoint']
    );
  }
}
