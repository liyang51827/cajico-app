class MyPage {
  MyPage({
    required this.familyName,
    required this.familyCode,
    required this.email,
    required this.userName,
    required this.position,
    required this.iconUrl,
    required this.todayPoint,
    required this.totalPoint,
    required this.ownedPoint,
  });

  final String familyName;
  final String familyCode;
  final String email;
  final String userName;
  final String position;
  final String iconUrl;
  final int todayPoint;
  final int totalPoint;
  final int ownedPoint;

  static MyPage fromJson(Map<String, dynamic> json) {
    return MyPage(
      familyName: json['familyName'],
      familyCode: json['familyCode'],
      email: json['email'],
      userName: json['userName'],
      position: json['position'],
      iconUrl: json['iconUrl'],
      todayPoint: json['todayPoint'],
      totalPoint: json['totalPoint'],
      ownedPoint: json['ownedPoint'],
    );
  }
}
