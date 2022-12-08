import 'package:get/get.dart';
import '../../model/family_reward.dart';
import 'base_view_controller.dart';

class RewardViewController extends BaseViewController {

  final RxList<FamilyReward> familyRewards = <FamilyReward>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
        familyRewards.value = await api.getFamilyRewardList();
    });
  }
}
