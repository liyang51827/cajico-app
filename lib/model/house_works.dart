class HouseWork {
  HouseWork({
    required this.categoryImageUrl,
    required this.name,
    required this.point
  });

  final String categoryImageUrl;
  final String name;
  final int point;

  static HouseWork fromJson(Map<String, dynamic> json) {
    return HouseWork(
      categoryImageUrl: json['name'],
      name: json['name'],
      point: json['point'],
    );
  }
}
