import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/schedule_data.dart';
import 'base_view_controller.dart';

class ScheduleCreateViewController extends BaseViewController {
  ScheduleCreateViewController({required this.date});
  final DateTime? date;
  final today = DateTime.now();
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
      scheduleCreateData.date.value = outputFormat.format(date!);
      scheduleCreateData.startTime.value = DateFormat.Hm().format(today);
      scheduleCreateData.endTime.value = DateFormat.Hm().format(today.add(const Duration(minutes: 10)));
    });
  }
}
