class MyPage {
  MyPage({
    required this.familyName,
    required this.familyCode,
    required this.email,
    required this.userName,
    required this.positionId,
    required this.positionName,
    required this.iconUrl,
    required this.todayPoint,
    required this.totalPoint,
    required this.ownedPoint,
    required this.isOnlyMe,
  });

  final String familyName;
  final String familyCode;
  final String email;
  final String userName;
  final int positionId;
  final String positionName;
  final String? iconUrl;
  final int todayPoint;
  final int totalPoint;
  final int ownedPoint;
  final bool isOnlyMe;

  static MyPage fromJson(Map<String, dynamic> json) {
    return MyPage(
      familyName: json['familyName'],
      familyCode: json['familyCode'],
      email: json['email'],
      userName: json['userName'],
      positionId: json['positionId'],
      positionName: json['positionName'],
      iconUrl: json['iconUrl'],
      todayPoint: json['todayPoint'],
      totalPoint: json['totalPoint'],
      ownedPoint: json['ownedPoint'],
      isOnlyMe: json['isOnlyMe'],
    );
  }
}
