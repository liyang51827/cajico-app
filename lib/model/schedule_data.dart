import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ScheduleCreateData {
  ScheduleCreateData({
    required this.date,
    required this.houseWorkId,
    required this.startTime,
    required this.endTime,
    required this.colorCode,
    required this.repeatRule,
    required this.repeatInterval,
    required this.repeatEndDate,
  });

  final RxString date;
  final RxInt houseWorkId;
  final RxString startTime;
  final RxString endTime;
  final RxString colorCode;
  final RxInt repeatRule;
  final RxInt repeatInterval;
  final RxString repeatEndDate;
}

class ScheduleEditData {
  ScheduleEditData({
    required this.scheduleId,
    required this.date,
    required this.houseWorkId,
    required this.startTime,
    required this.endTime,
    required this.colorCode,
    required this.repeatRule,
    required this.repeatInterval,
    required this.repeatEndDate,
  });

  final RxInt scheduleId;
  final RxString date;
  final RxInt houseWorkId;
  final RxString startTime;
  final RxString endTime;
  final RxString colorCode;
  final RxInt repeatRule;
  final RxInt repeatInterval;
  final RxString repeatEndDate;
}
