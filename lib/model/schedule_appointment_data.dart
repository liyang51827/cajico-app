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
