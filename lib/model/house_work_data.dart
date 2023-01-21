import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HouseWorkCreateData {
  HouseWorkCreateData({
    required this.houseWorkCategoryId,
    required this.houseWorkName,
    required this.point,
  });

  final RxInt houseWorkCategoryId;
  final RxString houseWorkName;
  final RxInt point;
}
