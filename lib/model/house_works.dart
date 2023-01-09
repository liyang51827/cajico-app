class HouseWork {
  HouseWork({
    required this.houseWorkId,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.name,
    required this.point
  });

  final int houseWorkId;
  final String categoryName;
  final String categoryImageUrl;
  final String name;
  final int point;

  static HouseWork fromJson(Map<String, dynamic> json) {
    return HouseWork(
      houseWorkId: json['id'],
      categoryName: json['houseWorkCategory']['name'],
      categoryImageUrl: json['houseWorkCategory']['uri'],
      name: json['name'],
      point: json['point'],
    );
  }
}
