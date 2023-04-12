import 'package:cajico_app/ui/controller/schedule_view_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/form_validation.dart';
import '../../model/masters.dart';
import '../../model/schedule_data.dart';
import '../../util/form_validator.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import 'base_view_controller.dart';

class ScheduleCreateViewController extends BaseViewController {
  ScheduleCreateViewController({required this.date});

  final DateTime? date;
  final today = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  final RxList<Master> houseWorks = <Master>[].obs;

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
    scheduleCreateData.date.value = outputFormat.format(date!);
    scheduleCreateData.startTime.value = DateFormat.Hm().format(today);
    scheduleCreateData.endTime.value =
        DateFormat.Hm().format(today.add(const Duration(minutes: 10)));
    await callAsyncApi(() async {
      houseWorks.value = await api.getAllHouseWorksList();
    });
  }

  FormValidation validateRequiredDropDown({int? value}) =>
      FormValidator.validateRequiredDropDown(value: value);

  FormValidation validateTimeAfterStartTime({String? value, required String? startTime}) =>
      FormValidator.validateTimeAfterStartTime(endTime: value, startTime: startTime);

  bool get isCreateScheduleValid =>
      validateRequiredDropDown(value: scheduleCreateData.houseWorkId()).isValid &&
      validateTimeAfterStartTime(value: scheduleCreateData.endTime(), startTime: scheduleCreateData.startTime()).isValid;

  Future<void> onTapCreateDialog() async {
    final scheduleController = Get.put(ScheduleViewController());
    var result = false;
    Get.dialog(
      NormalDialog(
        message: '登録しますか？',
        onPressed: () async {
          Get.back();
          await callAsyncApi(() async {
            result = await api.createSchedule(scheduleCreateData);
          });
          if (result) {
            Get.dialog(
              NormalCompletedDialog(
                message: '登録されました',
                onPressed: () {
                  Get.back();
                  Get.back();
                  scheduleController.fetchData();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
