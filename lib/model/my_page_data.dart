import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'dart:io';

class MyPageData {
  MyPageData({
    required this.familyName,
    required this.familyCode,
    required this.userName,
    required this.positionId,
    required this.iconImage,
  });

  final RxString familyName;
  final RxString familyCode;
  final RxString userName;
  final RxInt positionId;
  final Rxn<File> iconImage;
}
