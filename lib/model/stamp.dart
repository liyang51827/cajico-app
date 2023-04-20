class Stamp {
  Stamp({
    required this.stampId,
    required this.stampName,
    required this.stampUrl,
  });

  final int stampId;
  final String stampName;
  final String stampUrl;

  static Stamp fromJson(Map<String, dynamic> json) {
    return Stamp(
      stampId: json['id'],
      stampName: json['name'],
      stampUrl: json['url'],
    );
  }
}
