import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/schedule_appointment_data.dart';
import 'base_view_controller.dart';

class ScheduleViewController extends BaseViewController {
  final RxList<ScheduleAppointmentSummary> appoints = <ScheduleAppointmentSummary>[].obs;
  final RxInt calendarType = 1.obs;
  final Rx<DateTime?> selectedDateTime = Rxn<DateTime?>();
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

  Future<void> onTapSelectedDate({required selectedDate}) async {
    selectedDateTime.value = selectedDate;
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
}
