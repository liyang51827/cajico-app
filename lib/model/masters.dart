class Master {
  Master({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  static Master fromJson(Map<String, dynamic> json) {
    return Master(
      id: json['id'],
      name: json['name'],
    );
  }
}
