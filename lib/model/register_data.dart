import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'dart:io';

class NewFamilyData {
  NewFamilyData({
    required this.familyName,
    required this.familyCode,
    required this.userName,
    required this.positionId,
    required this.birthday,
    required this.password,
    required this.deviceToken,
    required this.token,
    required this.iconImage,
  });

  final RxString familyName;
  final RxString familyCode;
  final RxString userName;
  final RxInt positionId;
  final RxString birthday;
  final RxString password;
  final RxString token;
  final RxString deviceToken;
  final Rxn<File> iconImage;
}
