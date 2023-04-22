import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/schedule_appointment_data.dart';
import 'base_view_controller.dart';

class ScheduleViewController extends BaseViewController {
  final RxList<ScheduleAppointmentSummary> appoints = <ScheduleAppointmentSummary>[].obs;
  final RxInt calendarType = 0.obs;
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');

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
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('calendarType') == null) {
      prefs.setInt('calendarType', 0);
    }
    calendarType.value = prefs.getInt('calendarType')!;
  }

  Future<void> onViewChangedGetSchedule({required DateTime? dateTime}) async {
    await callAsyncApi(() async {
      String date = outputFormat.format(dateTime ?? DateTime.now());
      appoints.value = await api.getWeeklyScheduleAppointmentList(date: date);
    });
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
