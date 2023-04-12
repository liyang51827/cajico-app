import 'package:cajico_app/model/schedule_appointment_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/form_validation.dart';
import '../../model/masters.dart';
import '../../model/schedule_data.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class ScheduleEditViewController extends BaseViewController {
  ScheduleEditViewController({required this.date, required this.appointment});

  final ScheduleAppointment appointment;
  final DateTime date;
  final today = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  final RxList<Master> houseWorks = <Master>[].obs;

  final scheduleEditData = ScheduleEditData(
    scheduleId: 0.obs,
    date: ''.obs,
    houseWorkId: 0.obs,
    startTime: ''.obs,
    endTime: ''.obs,
    colorCode: ''.obs,
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
    scheduleEditData.scheduleId.value = appointment.scheduleId;
    scheduleEditData.date.value = outputFormat.format(date);
    scheduleEditData.houseWorkId.value = appointment.houseWorkId;
    scheduleEditData.startTime.value = DateFormat.Hm().format(appointment.startTime);
    scheduleEditData.endTime.value = DateFormat.Hm().format(appointment.endTime);
    scheduleEditData.colorCode.value =
        '#${appointment.color.value.toRadixString(16).toUpperCase().padLeft(8, '0')}';
    scheduleEditData.repeatRule.value = appointment.repeatRule ?? 999;
    scheduleEditData.repeatInterval.value = appointment.repeatInterval ?? 0;
    scheduleEditData.repeatEndDate.value =
        appointment.repeatEndDate != null ? outputFormat.format(appointment.repeatEndDate!) : '';
    await callAsyncApi(() async {
      houseWorks.value = await api.getAllHouseWorksList();
    });
  }

  FormValidation validateRequiredDropDown({int? value}) =>
      FormValidator.validateRequiredDropDown(value: value);

  FormValidation validateTimeAfterStartTime({String? value, required String? startTime}) =>
      FormValidator.validateTimeAfterStartTime(endTime: value, startTime: startTime);

  bool get isCreateScheduleValid =>
      validateRequiredDropDown(value: scheduleEditData.houseWorkId()).isValid &&
      validateTimeAfterStartTime(
              value: scheduleEditData.endTime(), startTime: scheduleEditData.startTime())
          .isValid;
}
