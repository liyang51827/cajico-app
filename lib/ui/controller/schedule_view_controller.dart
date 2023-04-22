import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/schedule_appointment_data.dart';
import 'base_view_controller.dart';

class ScheduleViewController extends BaseViewController {
  final RxList<ScheduleAppointmentSummary> appoints = <ScheduleAppointmentSummary>[].obs;
  final RxInt calendarType = 1.obs;
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      DateTime now = DateTime.now();
      String weekStartDate = outputFormat.format(now.subtract(Duration(days: now.weekday - 1)));
      appoints.value = await api.getWeeklyScheduleAppointmentList(date: weekStartDate);
    });
  }

  Future<void> onViewChangedGetSchedule({required DateTime? dateTime}) async {
    await callAsyncApi(() async {
      DateTime date = dateTime ?? DateTime.now();
      String weekStartDate = outputFormat.format(date.subtract(Duration(days: date.weekday - 1)));
      appoints.value = await api.getWeeklyScheduleAppointmentList(date: weekStartDate);
    });
  }

  Future<void> onViewChangedCalenderType({required int type}) async {
    calendarType.value = type;
  }

  Future<void> onTapChangedCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    if (calendarType() == 0) {
      prefs.setInt('calendarType', 1);
    } else if (calendarType() == 1) {
      prefs.setInt('calendarType', 0);
    }
    fetchData();
  }
}
