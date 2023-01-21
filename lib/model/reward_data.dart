import 'package:get/get_rx/src/rx_types/rx_types.dart';

class RewardData {
  RewardData({
    required this.rewardId,
    required this.rewardName,
    required this.point,
    required this.memo,
    required this.minPoint,
    required this.maxPoint,
  });

  final RxInt rewardId;
  final RxString rewardName;
  final RxInt point;
  final RxString memo;
  final RxInt minPoint;
  final RxInt maxPoint;
}
