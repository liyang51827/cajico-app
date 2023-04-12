import 'dart:ui';

class ScheduleAppointmentSummary {
  ScheduleAppointmentSummary({
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.color,
    required this.status,
  });

  final int scheduleId;
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;
  final String status;

  static ScheduleAppointmentSummary fromJson(Map<String, dynamic> json) {
    return ScheduleAppointmentSummary(
      scheduleId: json['id'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      subject: json['subject'],
      color: Color(int.parse(json['color'].replaceAll('#', '0x'))),
      status: json['status'],
    );
  }
}

class ScheduleAppointment {
  ScheduleAppointment({
    required this.scheduleId,
    required this.houseWorkId,
    required this.houseWorkName,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.status,
    this.completedUser,
    required this.point,
    this.repeatRule,
    this.repeatInterval,
    this.repeatEndDate,
    this.displayRepeatRule,
  });

  final int scheduleId;
  final int houseWorkId;
  final String houseWorkName;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final String status;
  final String? completedUser;
  final int point;
  final int? repeatRule;
  final int? repeatInterval;
  final String? repeatEndDate;
  final String? displayRepeatRule;

  static ScheduleAppointment fromJson(Map<String, dynamic> json) {
    return ScheduleAppointment(
      scheduleId: json['id'],
      houseWorkId: json['houseWork']['id'],
      houseWorkName: json['houseWork']['name'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      color: Color(int.parse(json['color'].replaceAll('#', '0x'))),
      status: json['status'],
      completedUser: json['completedUser'],
      point: json['houseWork']['point'],
      repeatRule: json['repeatRule'],
      repeatInterval: json['repeatInterval'],
      repeatEndDate: json['repeatEndDate'],
      displayRepeatRule: json['displayRepeatRule'],
    );
  }
}
