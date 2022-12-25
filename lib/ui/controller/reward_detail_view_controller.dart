import 'package:cajico_app/model/reward_history.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class RewardDetailViewController extends BaseViewController {
  RewardDetailViewController({required this.rewardId});

  final int rewardId;
  final RxList<RewardHistory> rewardHistories = <RewardHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      rewardHistories.value = await api.getRewardHistoryList(rewardId);
    });
  }

  Future<void> onTapRequest({required int rewardId}) async {
    var result = false;
    await callAsyncApi(() async {
      result = await api.requestReward(rewardId: rewardId);
    });
    if (result) {
      fetchData();
    }
  }
}
