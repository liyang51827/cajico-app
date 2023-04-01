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

class AdminNotice {
  AdminNotice({
    required this.id,
    required this.date,
    required this.title,
    required this.message,
    required this.isRead
  });

  final int id;
  final String date;
  final String title;
  final String message;
  final bool isRead;

  static AdminNotice fromJson(Map<String, dynamic> json) {
    return AdminNotice(
      id: json['id'],
      date: json['createdAt'],
      title: json['title'],
      message: json['message'],
      isRead: json['isAlreadyRead'],
    );
  }
}
