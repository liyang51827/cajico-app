import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/schedule_appointment_data.dart';
import 'base_view_controller.dart';

class ScheduleDetailViewController extends BaseViewController {
  ScheduleDetailViewController({required this.scheduleId, required this.date});
  final int scheduleId;
  final DateTime date;
  final appoint = Rxn<ScheduleAppointment>();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      String day = outputFormat.format(date);
      appoint.value = await api.getAppointment(scheduleId: scheduleId, date: day);
    });
  }
}
