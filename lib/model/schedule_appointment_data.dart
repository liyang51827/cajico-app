import 'dart:ui';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ScheduleAppointment {
  ScheduleAppointment({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.color,
    required this.status,
    required this.userName,
    required this.point,
    this.repeatRule,
  });

  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;
  final String status;
  final String userName;
  final int point;
  final String? repeatRule;

  static ScheduleAppointment fromJson(Map<String, dynamic> json) {
    return ScheduleAppointment(
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      subject: json['subject'],
      color: Color(int.parse(json['color'].replaceAll('#', '0xff'))),
      status: json['status'],
      userName: json['userName'],
      point: json['point'],
      repeatRule: json['repeatRule'],
    );
  }
}
