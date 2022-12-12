import 'package:cajico_app/model/reward_history.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class RewardDetailViewController extends BaseViewController {

  final RxList<RewardHistory> rewardHistories = <RewardHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      rewardHistories.value = await api.getRewardHistoryList(1);
    });
  }
}
