import 'package:cajico_app/ui/controller/schedule_view_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/schedule_appointment_data.dart';
import '../widget/house_work_dialog.dart';
import 'base_view_controller.dart';

class ScheduleDetailViewController extends BaseViewController {
  ScheduleDetailViewController({required this.scheduleId, required this.date});

  final int scheduleId;
  final DateTime? date;
  final appoint = Rxn<ScheduleAppointment>();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      String day = outputFormat.format(date!);
      appoint.value = await api.getAppointment(scheduleId: scheduleId, date: day);
    });
  }

  Future<void> onTapCompleteDialog() async {
    Get.dialog(
      HouseWorkCompleteDialog(
        houseWorkName: appoint()!.houseWorkName,
        point: appoint()!.point,
        onPressed: () {
          Get.back();
          completeApi();
        },
      ),
    );
  }

  Future<void> completeApi() async {
    final scheduleController = Get.put(ScheduleViewController());
    var result = false;
    await callAsyncApi(() async {
      result = await api.completeSchedule(scheduleId: scheduleId, date: outputFormat.format(date!));
    });
    if (result) {
      fetchData();
      Get.dialog(HouseWorkCompletedDialog(
        point: appoint()!.point,
        onPressed: () {
          Get.back();
          Get.back();
          scheduleController.fetchData();
        },
      ));
    }
  }
}
