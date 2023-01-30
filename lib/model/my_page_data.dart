import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyPageData {
  MyPageData({
    required this.familyName,
    required this.familyCode,
    required this.userName,
    required this.position,
  });

  final RxString familyName;
  final RxString familyCode;
  final RxString userName;
  final RxString position;
}
