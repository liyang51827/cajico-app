import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'dart:io';

class NewFamilyData {
  NewFamilyData({
    required this.type,
    required this.familyName,
    required this.familyCode,
    required this.userName,
    required this.positionId,
    required this.password,
    required this.token,
    required this.iconImage,
  });

  final RxString type;
  final RxString familyName;
  final RxString familyCode;
  final RxString userName;
  final RxInt positionId;
  final RxString password;
  final RxString token;
  final Rxn<File> iconImage;
}
