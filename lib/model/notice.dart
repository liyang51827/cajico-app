class Notice {
  Notice({
    required this.date,
    required this.message
  });

  final String date;
  final String message;

  static Notice fromJson(Map<String, dynamic> json) {
    return Notice(
      date: json['createdAt'],
      message: json['message'],
    );
  }
}
