class HouseWork {
  HouseWork({
    required this.houseWorkId,
    required this.categoryImageUrl,
    required this.name,
    required this.point
  });

  final int houseWorkId;
  final String categoryImageUrl;
  final String name;
  final int point;

  static HouseWork fromJson(Map<String, dynamic> json) {
    return HouseWork(
      houseWorkId: json['id'],
      categoryImageUrl: json['houseWorkCategory']['uri'],
      name: json['name'],
      point: json['point'],
    );
  }
}
