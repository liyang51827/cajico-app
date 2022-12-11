class Notice {
  Notice({
    required this.date,
    required this.message,
    required this.isRead
  });

  final String date;
  final String message;
  final bool isRead;

  static Notice fromJson(Map<String, dynamic> json) {
    return Notice(
      date: json['createdAt'],
      message: json['message'],
      isRead: json['isAlreadyRead'],
    );
  }
}
