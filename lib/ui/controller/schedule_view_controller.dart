import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../model/schedule_appointment_data.dart';
import 'base_view_controller.dart';

class ScheduleViewController extends BaseViewController {
  final RxList<ScheduleAppointmentSummary> appoints = <ScheduleAppointmentSummary>[].obs;
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  final List<Appointment> appointments = [
    Appointment(
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      subject: 'Meeting',
      color: Colors.blue,
      isAllDay: false,
    )
  ];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      DateTime now = DateTime.now();
      String date = outputFormat.format(now);
      appoints.value = await api.getScheduleAppointmentList(date: date);
    });
  }

  Future<void> onViewChangedGetSchedule({required DateTime? dateTime}) async {
    await callAsyncApi(() async {
      String date = outputFormat.format(dateTime!);
      appoints.value = await api.getScheduleAppointmentList(date: date);
    });
  }
}
