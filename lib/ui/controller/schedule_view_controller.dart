import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/schedule_appointment_data.dart';
import '../../model/schedule_data.dart';
import 'base_view_controller.dart';

class ScheduleViewController extends BaseViewController {
  final RxList<ScheduleAppointmentSummary> appoints = <ScheduleAppointmentSummary>[].obs;
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');

  final scheduleCreateData = ScheduleCreateData(
    date: ''.obs,
    houseWorkId: 0.obs,
    startTime: ''.obs,
    endTime: ''.obs,
    colorCode: '#FFF28E04'.obs,
    repeatRule: 999.obs,
    repeatInterval: 0.obs,
    repeatEndDate: ''.obs,
  );

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
