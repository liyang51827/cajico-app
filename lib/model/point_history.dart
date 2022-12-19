class PointHistory {
  PointHistory({
    required this.userName,
    required this.iconUrl,
    required this.todayPoint,
    required this.totalPoint,
    required this.pointHistories
  });

  final String userName;
  final String iconUrl;
  final int todayPoint;
  final int totalPoint;
  final List<Point> pointHistories;

  static PointHistory fromJson(Map<String, dynamic> json) {
    return PointHistory(
      userName: json['user']['userName'],
      iconUrl: json['user']['iconUrl'],
      todayPoint: json['todayPoint'],
      totalPoint: json['totalPoint'],
      pointHistories: (json['pointHistories'] as List)
          .map((data) => Point.fromJson(data))
          .toList(),
    );
  }
}

class Point {
  Point({
    required this.pointHistoryId,
    required this.iconUrl,
    required this.houseWorkCategoryName,
    required this.houseWorkCategoryImageUrl,
    required this.houseWorkName,
    required this.date,
    required this.time,
    required this.point,
    required this.isMe
  });

  final int pointHistoryId;
  final String iconUrl;
  final String houseWorkCategoryName;
  final String houseWorkCategoryImageUrl;
  final String houseWorkName;
  final String date;
  final String time;
  final int point;
  final bool isMe;

  static Point fromJson(Map<String, dynamic> json) {
    return Point(
      pointHistoryId: json['id'],
      iconUrl: json['icon']['uri'],
      houseWorkCategoryName: json['houseWorkCategory']['name'],
      houseWorkCategoryImageUrl: json['houseWorkCategory']['uri'],
      houseWorkName: json['name'],
      date: json['date'],
      time: json['time'],
      point: json['point'],
      isMe: json['isMe']
    );
  }
}

class TotalPointHistory {
  TotalPointHistory({
    required this.todayPoint,
    required this.totalPoint,
    required this.pointHistories
  });

  final int todayPoint;
  final int totalPoint;
  final List<Point> pointHistories;

  static TotalPointHistory fromJson(Map<String, dynamic> json) {
    return TotalPointHistory(
      todayPoint: json['todayPoint'],
      totalPoint: json['totalPoint'],
      pointHistories: (json['pointHistories'] as List)
          .map((data) => Point.fromJson(data))
          .toList(),
    );
  }
}

class TotalPoint {
  TotalPoint({
    required this.pointHistoryId,
    required this.iconUrl,
    required this.houseWorkCategoryName,
    required this.houseWorkCategoryImageUrl,
    required this.houseWorkName,
    required this.date,
    required this.time,
    required this.point,
    required this.isMe
  });

  final int pointHistoryId;
  final String iconUrl;
  final String houseWorkCategoryName;
  final String houseWorkCategoryImageUrl;
  final String houseWorkName;
  final String date;
  final String time;
  final int point;
  final bool isMe;

  static TotalPoint fromJson(Map<String, dynamic> json) {
    return TotalPoint(
        pointHistoryId: json['id'],
        iconUrl: json['icon']['uri'],
        houseWorkCategoryName: json['houseWorkCategory']['name'],
        houseWorkCategoryImageUrl: json['houseWorkCategory']['uri'],
        houseWorkName: json['name'],
        date: json['date'],
        time: json['time'],
        point: json['point'],
        isMe: json['isMe']
    );
  }
}
