import 'package:get/get.dart';
import '../../model/schedule_appointment_data.dart';
import 'base_view_controller.dart';

class ScheduleViewController extends BaseViewController {
  final RxList<ScheduleAppointment> appoints = <ScheduleAppointment>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      appoints.value = await api.getScheduleAppointmentList();
    });
  }
}
