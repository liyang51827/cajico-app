import 'package:get/get.dart';
import 'base_view_controller.dart';

class RewardEditViewController extends BaseViewController {
  RewardEditViewController();

  final rewardName = ''.obs;
  final point = 0.obs;
  final memo = ''.obs;

  Future<void> onTapUpdate(
      {required int rewardId,
      required String rewardName,
      required int point,
      required String memo}) async {
    await callAsyncApi(() async {
      await api.putReward(rewardId: rewardId, rewardName: rewardName, point: point, memo: memo);
    });
  }
}
